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
      win_options = {
         signcolumn = "auto",
      },
      delete_to_trash = true,
      keymaps = {
         ["<BS>"] = { "actions.parent", mode = "n" },
      },
   },
   -- Optional dependencies
   dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
   -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
   lazy = false,
   keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" },
   }
}
