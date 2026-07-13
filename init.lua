vim.loader.enable()
-- Pre-lazy configuration
require("config.filetypes")
require("config.neovide")
require("config.globals")
require("config.terminal")
require("config.options")
require("config.keymaps")
require("config.autocommands")
require("config.lsp_toggle")
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
      name = 'win32yank-wsl',
      copy = {
        ['+'] = 'win32yank.exe -i --crlf',
        ['*'] = 'win32yank.exe -i --crlf',
      },
      paste = {
        ['+'] = 'win32yank.exe -o --lf',
        ['*'] = 'win32yank.exe -o --lf',
      },
      cache_enabled = 0,  -- this is the key part
    }
end
-- Core functionalities
require("core.lazy") -- includes plugins
require("core.lsp")
-- Color scheme
vim.cmd "colorscheme jellybeans"

