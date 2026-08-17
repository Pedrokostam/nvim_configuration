-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
   group = last_cursor_group,
   callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
         pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
   end,
})

-- Highlight the yanked text for 200ms
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
   group = highlight_yank_group,
   pattern = "*",
   callback = function()
      vim.hl.on_yank({
         higroup = "IncSearch",
         timeout = 400,
      })
   end,
})

-- Lsp
vim.api.nvim_create_autocmd('LspAttach', {
   group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
   callback = function(event)
      -- defaults:
      -- https://neovim.io/doc/user/news-0.11.html#_defaults

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client or not client:supports_method('textDocument/completion') then
         return
      end
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

      -- When cursor stops moving: Highlights all instances of the symbol under the cursor
      -- When cursor moves: Clears the highlighting
      if client:supports_method("textDocument/documentHighlight") then
         vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
         })
         vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
         })
      end

      if client:supports_method("textDocument/foldingRange") then
         local win = vim.api.nvim_get_current_win()
         vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
      end
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
      -- When LSP detaches: Clears the highlighting
      vim.api.nvim_create_autocmd('LspDetach', {
         group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
         callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
         end,
      })
   end,
})
vim.api.nvim_create_user_command("WriteAndSource", function()
   if vim.bo.modified then
      vim.cmd("update")
      vim.cmd("source %")
      print("File updated and sourced")
   else
      print("No changes to save")
   end
end, {})
vim.cmd("cnoreabbrev wso WriteAndSource")
vim.api.nvim_create_user_command("WA", "wall", {})
vim.api.nvim_create_user_command("Wa", "wall", {})
vim.api.nvim_create_user_command("W", "write", {})
vim.api.nvim_create_user_command("WQA", "wqall", {})
vim.api.nvim_create_user_command("WQa", "wqall", {})

-- Floating window: LSP attach status + live-discovered LSP shortcuts (<C-?>)
-- Neovim built-in LSP/diagnostic default maps. `verify` confirms the key still
-- points at its intended function (drops it if you override or delete the default).
local builtin_lsp_maps = {
   { modes = { "n" },      lhs = "grn",   desc = "Rename all references",    verify = "vim%.lsp" },
   { modes = { "n", "x" }, lhs = "gra",   desc = "Code Action",             verify = "vim%.lsp" },
   { modes = { "n" },      lhs = "grr",   desc = "References",              verify = "vim%.lsp" },
   { modes = { "n" },      lhs = "gri",   desc = "Implementation",          verify = "vim%.lsp" },
   { modes = { "n" },      lhs = "grt",   desc = "Type Definition",         verify = "vim%.lsp" },
   { modes = { "n" },      lhs = "gO",    desc = "Document Symbols",        verify = "vim%.lsp" },
   { modes = { "i" },      lhs = "<C-s>", desc = "Signature Documentation", verify = "vim%.lsp" },
   { modes = { "n" },      lhs = "[d",    desc = "Prev Diagnostic",         verify = "[Dd]iagnostic" },
   { modes = { "n" },      lhs = "]d",    desc = "Next Diagnostic",         verify = "[Dd]iagnostic" },
}

local function collect_lsp_keymaps()
   local by_key, out = {}, {}
   local function add(lhs, desc, mode)
      local key = lhs .. "\0" .. desc
      local entry = by_key[key]
      if not entry then
         entry = { lhs = lhs, desc = desc, modes = {}, seen = {} }
         by_key[key] = entry
         out[#out + 1] = entry
      end
      if not entry.seen[mode] then
         entry.seen[mode] = true
         entry.modes[#entry.modes + 1] = mode
      end
   end

   for _, mode in ipairs({ "n", "i", "v", "x" }) do
      for _, list in ipairs({ vim.api.nvim_get_keymap(mode), vim.api.nvim_buf_get_keymap(0, mode) }) do
         for _, m in ipairs(list) do
            if m.desc and m.desc:match("^LSP:") then
               add(m.lhs, m.desc:gsub("^LSP:%s*", ""), mode)
            end
         end
      end
   end

   for _, b in ipairs(builtin_lsp_maps) do
      for _, mode in ipairs(b.modes) do
         local info = vim.fn.maparg(b.lhs, mode, false, true)
         local d = info.desc or info.rhs or ""
         if next(info) ~= nil and d:match(b.verify) then
            add(b.lhs, b.desc, mode)
         end
      end
   end

   table.sort(out, function(a, b) return a.desc < b.desc end)
   return out
end

local function show_lsp_info()
   local clients = vim.lsp.get_clients({ bufnr = 0 })
   local lines
   if #clients == 0 then
      lines = { "LSP: none attached to this buffer" }
   else
      local names = {}
      for _, c in ipairs(clients) do names[#names + 1] = c.name end
      lines = { "LSP attached: " .. table.concat(names, ", ") }
   end
   lines[#lines + 1] = ""
   lines[#lines + 1] = "Shortcuts:"

   local maps = collect_lsp_keymaps()
   local lhs_w, mode_w = 0, 0
   for _, m in ipairs(maps) do
      m.modestr = "[" .. table.concat(m.modes, ",") .. "]"
      lhs_w = math.max(lhs_w, #m.lhs)
      mode_w = math.max(mode_w, #m.modestr)
   end
   local fmt = "  %-" .. mode_w .. "s  %-" .. lhs_w .. "s   %s"
   for _, m in ipairs(maps) do
      lines[#lines + 1] = string.format(fmt, m.modestr, m.lhs, m.desc)
   end

   local buf = vim.api.nvim_create_buf(false, true)
   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
   vim.bo[buf].modifiable = false
   vim.bo[buf].bufhidden = "wipe"

   local width = 0
   for _, l in ipairs(lines) do width = math.max(width, vim.fn.strdisplaywidth(l)) end
   local height = #lines
   vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width + 2,
      height = height,
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      style = "minimal",
      border = "rounded",
      title = " LSP Info ",
      title_pos = "center",
   })
   for _, key in ipairs({ "q", "<Esc>" }) do
      vim.keymap.set("n", key, "<cmd>close<cr>", { buffer = buf, nowait = true, silent = true })
   end
end

vim.api.nvim_create_user_command("LspShortcuts", show_lsp_info, {})

local function open_lsp_info()
   vim.cmd("stopinsert")
   vim.schedule(show_lsp_info)
end

vim.api.nvim_create_user_command("SurroundVisual", function(opts)
	local args = opts.args
	local open, close

	if #args == 1 then
		open = args
		close = args
	else
		open = args:sub(1, 1)
		close = args:sub(2, 2)
	end

	local buf = 0

	local start = vim.api.nvim_buf_get_mark(buf, "<")
	local finish = vim.api.nvim_buf_get_mark(buf, ">")

	local start_row, start_col = start[1] - 1, start[2]
	local end_row, end_col = finish[1] - 1, finish[2]

	local text = vim.api.nvim_buf_get_text(
		buf,
		start_row,
		start_col,
		end_row,
		end_col + 1,
		{}
	)

	text[1] = open .. text[1]
	text[#text] = text[#text] .. close

	vim.api.nvim_buf_set_text(
		buf,
		start_row,
		start_col,
		end_row,
		end_col + 1,
		text
	)
end, {
	nargs = 1,
	range = true,
})
--
-- Single 'character' input (uses the same character for both sides)
vim.keymap.set("x", '\\"', ':SurroundVisual "<CR>', { silent = true, desc="Surround with single quote" })
vim.keymap.set("x", "\\'", ":SurroundVisual '<CR>", { silent = true, desc="Surround with double quotes" })
vim.keymap.set("x", "\\,", ":SurroundVisual ,<CR>", { silent = true, desc="Surround with commas" })

-- Two character input (char 1 for left, char 2 for right)
vim.keymap.set("x", "\\(", ":SurroundVisual ()<CR>", { silent = true, desc="Surround with paretheses" })
vim.keymap.set("x", "\\[", ":SurroundVisual []<CR>", { silent = true, desc="Surround with brackets" })
vim.keymap.set("x", "\\{", ":SurroundVisual {}<CR>", { silent = true, desc="Surround with curly braces" })
vim.keymap.set("x", "\\<", ":SurroundVisual <><CR>", { silent = true, desc="Surround with angle brackets" })

-- g? works everywhere; <C-?> only reaches Neovim in a GUI (terminals collapse it to <BS>)
vim.keymap.set({ "n", "x" }, "g?", open_lsp_info, { desc = "Show LSP info & shortcuts", silent = true })
vim.keymap.set({ "n", "i", "v" }, "<C-?>", open_lsp_info, { desc = "Show LSP info & shortcuts", silent = true })
vim.api.nvim_create_user_command("Wqa", "wqall", {})
