--vim.cmd('source ' .. vim.fn.stdpath('config') .. '/config.vim')
require("config.globals")
require("config.terminal")
require("config.options")
require("config.keymaps")
require("config.autocommands")
require("config.lazy")
-- require("lsp.init")
-- require("servers.init")
-- require("lsp_servers.init")


-- vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, expr = true })




--vim.api.nvim_create_autocmd("BufWritePre", {
--  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
--  callback = function()
--    vim.cmd("silent! %!clang-format")
--  end,
--})

vim.cmd "colorscheme nvimgelion"

