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
-- Core functionalities
require("core.lazy") -- includes plugins
require("core.lsp")
-- Color scheme
vim.cmd "colorscheme jellybeans"

