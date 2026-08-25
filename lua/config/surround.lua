-- Visual-mode surround: wrap the selection in a pair of characters.
-- Pure nvim buffer API (no plugin), so it works in both terminal nvim and
-- vscode-neovim (which syncs nvim buffer edits back to the VS Code document).
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

   local text = vim.api.nvim_buf_get_text(buf, start_row, start_col, end_row, end_col + 1, {})
   text[1] = open .. text[1]
   text[#text] = text[#text] .. close
   vim.api.nvim_buf_set_text(buf, start_row, start_col, end_row, end_col + 1, text)
end, { nargs = 1, range = true })

-- Single 'character' input (uses the same character for both sides)
vim.keymap.set("x", '\\"', ':SurroundVisual "<CR>', { silent = true, desc = "Surround with single quote" })
vim.keymap.set("x", "\\'", ":SurroundVisual '<CR>", { silent = true, desc = "Surround with double quotes" })
vim.keymap.set("x", "\\,", ":SurroundVisual ,<CR>", { silent = true, desc = "Surround with commas" })

-- Two character input (char 1 for left, char 2 for right)
vim.keymap.set("x", "\\(", ":SurroundVisual ()<CR>", { silent = true, desc = "Surround with paretheses" })
vim.keymap.set("x", "\\[", ":SurroundVisual []<CR>", { silent = true, desc = "Surround with brackets" })
vim.keymap.set("x", "\\{", ":SurroundVisual {}<CR>", { silent = true, desc = "Surround with curly braces" })
vim.keymap.set("x", "\\<", ":SurroundVisual <><CR>", { silent = true, desc = "Surround with angle brackets" })
