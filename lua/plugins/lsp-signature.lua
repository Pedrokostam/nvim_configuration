return {
   "ray-x/lsp_signature.nvim",
   event = "InsertEnter",
   opts = {
      bind = true,
      hint_prefix = {
         above = "↙ ", -- when the hint is on the line above the current line
         current = "← ", -- when the hint is on the same line
         below = "↖ " -- when the hint is on the line below the current line
      },
      hint_inline = function() return 'eol' end,
      handler_opts = {
         border = "rounded",
      }
   },
   -- or use config
   -- config = function(_, opts) require'lsp_signature'.setup({you options}) end
}
