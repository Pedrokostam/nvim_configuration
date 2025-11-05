return {
   "saecki/crates.nvim",
   dependencies = { "nvim-lua/plenary.nvim" },
   ft = "toml",
   lazy = true,
   opts = {
      lsp = {
         enabled = true,
         actions = true,
         completion = true,
         hover = true, -- enables crates info in LSP hover
         on_attach = function(client, bufnr)
            local crates = require("crates")
            local opts = { silent = true }
            vim.keymap.set("n", "<leader>ct", crates.toggle, {silent = true, desc = "Toggle"})
            vim.keymap.set("n", "<leader>cr", crates.reload, {silent = true, desc = "Reload"})
            vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, {silent = true, desc = "Show_versions_popup"})
            vim.keymap.set("n", "<leader>cf", crates.show_features_popup, {silent = true, desc = "Show_features_popup"})
            vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, {silent = true, desc = "Show_dependencies_popup"})
            vim.keymap.set("n", "<leader>cu", crates.update_crate, {silent = true, desc = "Update_crate"})
            vim.keymap.set("v", "<leader>cu", crates.update_crates, {silent = true, desc = "Update_crates"})
            vim.keymap.set("n", "<leader>ca", crates.update_all_crates, {silent = true, desc = "Update_all_crates"})
            vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, {silent = true, desc = "Upgrade_crate"})
            vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, {silent = true, desc = "Upgrade_crates"})
            vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, {silent = true, desc = "Upgrade_all_crates"})
            vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, {silent = true, desc = "Expand_plain_crate_to_inline_table"})
            vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, {silent = true, desc = "Extract_crate_into_table"})
            vim.keymap.set("n", "<leader>cR", crates.open_repository, {silent = true, desc = "Open_repository"})
            vim.keymap.set("n", "<leader>cD", crates.open_documentation, {silent = true, desc = "Open_documentation"})
            vim.keymap.set("n", "<leader>cC", crates.open_crates_io, {silent = true, desc = "Open_crates_io"})
            vim.keymap.set("n", "<leader>cL", crates.open_lib_rs, {silent = true, desc = "Open_lib_rs"})
         end,
      },
   },
   keys = {

      { "<leader>tt", "<Cmd> ToggleTerm <CR>", desc = "Toggle Terminal pane" },
   },
}
