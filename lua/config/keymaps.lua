-- require("config.globals")
-- local cmdEscape
-- if vim.g.os == "Wim" then
--    cmdEscape = "<S-Esc>"
-- else
--    cmdEscape = "<C-Esc>"
-- end
-- vim.keymap.set({ "i", "v", "o", "c", "t" }, cmdEscape, "<Esc>:", { noremap = true, silent = true })

-- Clipboard
vim.keymap.set({ 'n', 'v' }, '<C-y>', '"+y')
vim.keymap.set('n', '<C-p>', '"+p')

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "<leader>j", "i<CR><Esc>", { desc = "Break line at cursor" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("v", "<A-k>", ':m \'<-2<CR>gv=gv', { noremap = true, silent = true })
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true })

vim.keymap.set('n', '<A-k>', ':m .-2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-j>', ':m .+1<CR>', { noremap = true, silent = true })

vim.keymap.set("v", "<A-Up>", ':m \'<-2<CR>gv=gv', { noremap = true, silent = true })
vim.keymap.set('v', '<A-Down>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>', { noremap = true, silent = true })

vim.keymap.set("i", "<C-l>", "<C-X><C-O>", { desc = "Get completion", noremap = true, silent = true })
-- Windows terminal does not like C-Space, so we have C-Z
vim.keymap.set("i", "<C-z>", "<C-X><C-O>", { desc = "Get completion", noremap = true, silent = true })
-- The preferred binding
vim.keymap.set("i", "<C-Space>", "<C-X><C-O>", { desc = "Get completion", noremap = true, silent = true })

vim.keymap.set({ "n", "i", "v" }, "<F12>", function() vim.lsp.buf.definition() end, { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<C-F12>", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>",
   { desc = "LSP: Goto Definition in Vertical Split" })
vim.keymap.set({ "n", "i", "v" }, "<S-F12>", "<cmd>split | lua vim.lsp.buf.definition()<cr>",
   { desc = "LSP: Goto Definition in Horizontal Split" })

-- LSP

vim.keymap.set({ 'n' }, "gl", vim.diagnostic.open_float, { desc = "LSP: Open Diagnostic Float" })
vim.keymap.set({ 'n' }, "K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation" })
vim.keymap.set({ 'n' }, "gs", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation" })
vim.keymap.set({ 'n' }, "gD", vim.lsp.buf.declaration, { desc = "LSP: Goto Declaration" })
vim.keymap.set({ 'n' }, "<leader>la", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
vim.keymap.set({ 'n' }, "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: Rename all references" })
vim.keymap.set({ 'n' }, "<leader>lf", vim.lsp.buf.format, { desc = "LSP: Format" })
vim.keymap.set({ 'n' }, "<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>",
   { desc = "LSP: Goto Definition in Vertical Split" })
vim.keymap.set({ 'n' }, "<leader>h", "<cmd>split | lua vim.lsp.buf.definition()<cr>",
   { desc = "LSP: Goto Definition in Horizontal Split" })

local accept_func = function(key)
   if vim.fn.pumvisible() == 1 then
      return vim.api.nvim_replace_termcodes("<C-y>", true, true, true)
   else
      return key
   end
end
vim.keymap.set("i", "<Tab>", function() return accept_func("\t") end, { expr = true })
vim.keymap.set("i", "<Enter>", function() return accept_func("\r") end, { expr = true })

-- Display and formatting
vim.keymap.set(
   { "i", "n" },
   "<F3>v",
   function()
      vim.wo.list = not vim.wo.list
   end,
   { desc = "Toggle invisble characters" }
)
vim.keymap.set({ "i", "n" }, "<F3>w", function() vim.wo.wrap = not vim.wo.wrap end, { desc = "Toggle wrapping" })
vim.keymap.set({ "i", "n" }, "<F3>fd", function() vim.bo.fileformat = 'dos' end, { desc = "Set format to DOS (CRLF)" })
vim.keymap.set({ "i", "n" }, "<F3>fu", function() vim.bo.fileformat = 'unix' end, { desc = "Set format to UNIX (LR)" })
vim.keymap.set({ "i", "n" }, "<F3>fm", function() vim.bo.fileformat = 'mac' end, { desc = "Set format to MAC (CR)" })
