-- Pre-lazy configuration
require("config.globals")
require("config.terminal")
require("config.options")
require("config.keymaps")
require("config.autocommands")
-- Core functionalities
require("core.lazy") -- includes plugins
require("core.lsp")
-- Color scheme
vim.cmd "colorscheme jellybeans"

