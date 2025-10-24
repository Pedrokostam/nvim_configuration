return {
   {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "MunifTanjim/nui.nvim",
         "nvim-tree/nvim-web-devicons", -- optional, but recommended
      },
      lazy = false,                     -- neo-tree will lazily load itself
      opts = {
         window = {
            position = "left",
            width = 30,
         }
      },
      keys = {

         { "<leader>n", "<Cmd> Neotree toggle  <CR>",         mode = "n", desc = "Toggle file tree" },
         { "<leader>N", "<Cmd> Neotree toggle buffers  <CR>", mode = "n", desc = "Toggle buffer tree" },
      },
   }
}
