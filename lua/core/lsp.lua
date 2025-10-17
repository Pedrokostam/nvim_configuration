-- vim.lsp.config("lua_ls",require("lsp.lua_ls"))

-- ~/.config/nvim/lua/lsp/init.lua
local servers = {
   "lua_ls",
   "rust_analyzer",
   "csharp_ls",
   "powershell_es",
   "ruff",
   "clangd",
   "cmake",
   "jsonls",
}

-- I know it should be easier to merge configs from lspconfig in Lazy, but oh well...
local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp"
for _, name in ipairs(servers) do
   local file = string.format("%s/%s.lua", lsp_dir, name)
   if vim.fn.filereadable(file) == 1 then
      local ok, config = pcall(dofile, file)
      if ok and type(config) == "table" then
         -- vim.notify("Overriden with "..name,vim.log.levels.WARN)
         vim.lsp.config(name, config)
      end
   end
end
-- If I find out how to do it we can delete this.

vim.lsp.enable(servers)
