-- Status line
-- https://github.com/folke/lazydev.nvim
return {
   {
      'nvim-lualine/lualine.nvim',
      lazy = false,
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function(_, opts)
         require('lualine').setup {
            options = {
               icons_enabled = true,
               theme = 'jellybeans',
               component_separators = { left = '|', right = '|' },
               section_separators = { '' },
               disabled_filetypes = {
                  statusline = {},
                  winbar = {},
               },
               ignore_focus = {},
               always_divide_middle = true,
               always_show_tabline = false,
               globalstatus = false,
               refresh = {
                  statusline = 1000,
                  tabline = 1000,
                  winbar = 1000,
                  refresh_time = 16, -- ~60f ps
                  events = {
                     'WinEnter',
                     'BufEnter',
                     'BufWritePost',
                     'SessionLoadPost',
                     'FileChangedShellPost',
                     'VimResized',
                     'Filetype',
                     'CursorMoved',
                     'CursorMovedI',
                     'ModeChanged',
                  },
               }
            },
            sections = {
               lualine_a = { 'mode' },
               lualine_b = { 'branch', 'diff', 'diagnostics' },
               lualine_c = {
                  'filename',
                  {
                     require("lazy.status").updates,
                     cond = require("lazy.status").has_updates,
                     color = { fg = "#ff9e64" },
                  }
               },
               lualine_x = { 'searchcount', 'selectioncount' },
               lualine_y = { { 'encoding', show_bomb = true }, 'fileformat', 'filetype' },
               lualine_z = { 'progress', 'location' }
            },
            inactive_sections = {
               lualine_a = {},
               lualine_b = {},
               lualine_c = { 'filename' },
               lualine_x = { 'location' },
               lualine_y = {},
               lualine_z = {}
            },
            tabline = {
               lualine_a = {
                  'tabs'
               },
            },
            winbar = {},
            inactive_winbar = {},
            extensions = {}
         }
      end,
   },


}
