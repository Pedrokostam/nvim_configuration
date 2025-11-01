return {
   'mrcjkb/rustaceanvim',
   version = '^6', -- Recommended
   lazy = false,   -- This plugin is already lazy
   ft = "rust",
   dependencies = {
      "mfussenegger/nvim-dap"
   },
   config = function()
      local dap = require("dap")
      dap.set_exception_breakpoints({ "all" })
   end,
}
