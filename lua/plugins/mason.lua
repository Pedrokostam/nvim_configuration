-- Install utilities for other plugins
-- https://github.com/mason-org/mason.nvim
-- mason.nvim has no built-in ensure_installed; install missing packages after setup.
local ensure_installed = {
   "cmake-language-server",
   "csharp-language-server",
   "lemminx",
   "powershell-editor-services",
}

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
   },
   config = function(_, opts)
      require("mason").setup(opts)
      local registry = require("mason-registry")
      registry.refresh(function()
         for _, name in ipairs(ensure_installed) do
            local ok, pkg = pcall(registry.get_package, name)
            if ok and not pkg:is_installed() then
               pkg:install()
            end
         end
      end)
   end
}
