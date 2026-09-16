-- Indentation guide lines
-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
   "lukas-reineke/indent-blankline.nvim",
   main = "ibl",
   event = "BufReadPre",
   config = function()
      -- ponytail: hardcoded dim grey; re-set on ColorScheme if you switch themes
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#1f1f1f", nocombine = true })
      require("ibl").setup({})
   end,
}
