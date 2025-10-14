return {
	{
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
},
	{
		"neovim/nvim-lspconfig",
		config = function()
		end,
	},
	{
    "TheLeoP/powershell.nvim",
    ---@type powershell.user_config
    opts = {
      bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services"
    }
}
}
