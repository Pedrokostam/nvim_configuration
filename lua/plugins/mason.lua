-- Install utilities for other plugins
-- https://github.com/mason-org/mason.nvim
return {
   "mason-org/mason.nvim",
   opts = {
      ui = {
         icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
         }
      }
   }
}
