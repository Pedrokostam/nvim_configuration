-- https://github.com/akinsho/toggleterm.nvim
return {
   -- amongst your other plugins
   {
      'akinsho/toggleterm.nvim',
      config = true,
      opts = {

      },
      keys = {
         { "<leader>tt", "<Cmd> ToggleTerm <CR>", desc = "Toggle Terminal pane" },
         { "<leader>tf", "<Cmd> ToggleTerm direction=float <CR>", desc = "Toggle floating Terminal pane" },
         { "<leader>tv", "<Cmd> ToggleTerm direction=vertical <CR>", desc = "Toggle vertical Terminal pane" },
         { "<leader>th", "<Cmd> ToggleTerm direction=horizontal <CR>", desc = "Toggle horizontal Terminal pane" },
      },
   }
}
