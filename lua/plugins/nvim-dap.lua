return {
   "mfussenegger/nvim-dap",
   lazy = true,
   -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
   -- modified.
   keys = {
      {
         "<F9>",
         function() require("dap").toggle_breakpoint() end,
         desc = "Toggle Breakpoint"
      },
      {
         "<F5>",
         function() require("dap").continue() end,
         desc = "Continue"
      },
      {
         "<C-F9>",
         function() require("dap").run_to_cursor() end,
         desc = "Run to Cursor"
      },
      {
         "<F10>",
         function() require('dap').step_over() end,
         desc = "Step Over"
      },
      {
         "<F11>",
         function() require('dap').step_over() end,
         desc = "Step Into"
      },
      {
         "<S-F11>",
         function() require('dap').step_over() end,
         desc = "Step Out"
      },
      {
         "<S-F5>",
         function() require("dap").terminate() end,
         desc = "Terminate"
      },
   },
}
