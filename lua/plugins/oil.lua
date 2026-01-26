-- Buffer-like file manager
-- https://github.com/stevearc/oil.nvim
return {
   'stevearc/oil.nvim',
   ---@module 'oil'
   ---@type oil.SetupOpts
   opts = {
      columns = {
         "icon",
         "size",
      },
      skip_confirm_for_simple_edits = true,
      win_options = {
         signcolumn = "auto",
      },
      lsp_file_methods = {
         -- Enable or disable LSP file operations
         enabled = true,
         -- Time to wait for LSP file operations to complete before skipping
         timeout_ms = 2500,
         -- Set to true to autosave buffers that are updated with LSP willRenameFiles
         -- Set to "unmodified" to only save unmodified buffers
         autosave_changes = false,
      },
      delete_to_trash = false,
      view_options = {
         case_insensitive = true,
         show_hidden = true,
      },
      keymaps = {
         ["<C-h>"] = false,
         ["<C-l>"] = false,
         -- Map F5 to the refresh action
         ["<F5>"] = "actions.refresh",
         ["<BS>"] = { "actions.parent", mode = "n" },
         ["<leader>ot"] = { "actions.open_terminal", mode = "n" },
         ["gya"] = { "actions.yank_entry", mode = "n", opts = { modify = ':p' }, desc = "Yank absolute path" },
         ["gyR"] = { "actions.yank_entry", mode = "n", opts = { modify = ':.' }, desc = "Yank relative path" },
         ["gyn"] = { "actions.yank_entry", mode = "n", opts = { modify = ':t' }, desc = "Yank name with extension" },
         ["<leader>e"] = { "actions.close", mode = "n" },
         ["<S-Down>"] = { "actions.preview_scroll_down", mode = "n" },
         ["J"] = { "actions.preview_scroll_down", mode = "n" },
         ["<S-Up>"] = { "actions.preview_scroll_up", mode = "n" },
         ["K"] = { "actions.preview_scroll_up", mode = "n" },
         ["<C-S>"] = { "oil.save", mode = { "n", "i" } },
      },
   },
   -- Optional dependencies
   dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
   -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
   lazy = false,
   keys = {
      { "<leader>e", "<cmd>Oil<cr>",          desc = "Open Oil (window)" },
      { "<leader>E", "<cmd>Oil --float <cr>", desc = "Open Oil (float)" },
   }
}
