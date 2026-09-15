-- Miscapitalizations of :w / :wa / :wqa. Shared by plain nvim and vscode-neovim
-- (:w-family commands save the VS Code document under the extension).
vim.api.nvim_create_user_command("W", "write", {})
vim.api.nvim_create_user_command("WA", "wall", {})
vim.api.nvim_create_user_command("Wa", "wall", {})
vim.api.nvim_create_user_command("WQA", "wqall", {})
vim.api.nvim_create_user_command("WQa", "wqall", {})
vim.api.nvim_create_user_command("Wqa", "wqall", {})
