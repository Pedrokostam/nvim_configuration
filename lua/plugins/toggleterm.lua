-- https://github.com/akinsho/toggleterm.nvim
return {
   -- amongst your other plugins
   {
      'akinsho/toggleterm.nvim',
      config = true,
      keys = { { "<leader>tt", "<Cmd> ToggleTerm<CR>", desc = "Toggle Terminal pane" } },
   }
}
