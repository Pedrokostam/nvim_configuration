-- Install LSPs
-- https://github.com/mason-org/mason-lspconfig.nvim
return {
   "mason-org/mason-lspconfig.nvim",
   lazy = false,
   opts = {
      automatic_enable = false,
      ensure_installed = {
         "lua_ls",
         "rust_analyzer",
         "csharp_ls",
         "powershell_es",
         "ruff",
         "clangd",
         "cmake",
         "jsonls",
      },
   },
   dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
   },
}
