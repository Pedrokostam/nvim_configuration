vim.loader.enable()

-- Shared by both plain nvim and vscode-neovim (pure buffer API, no plugins).
require("config.surround")

if vim.g.vscode then
  -- Running inside vscode-neovim: VS Code owns UI, LSP, files, terminal, colors.
  -- Load only editing behavior, then re-point nvim-specific maps at VS Code commands.
  require("config.globals")
  require("config.options")
  require("config.keymaps")
  require("config.vscode")
  return
end

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
