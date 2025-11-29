-- -- vim.lsp.config("lua_ls",require("lsp.lua_ls"))
--
-- -- ~/.config/nvim/lua/lsp/init.lua
-- local servers = {
--    "lua_ls",
--    "rust_analyzer",
--    "csharp_ls",
--    "powershell_es",
--    "ruff",
--    "clangd",
--    "cmake",
--    "jsonls",
-- }
--
-- -- I know it should be easier to merge configs from lspconfig in Lazy, but oh well...
-- local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp"
-- for _, name in ipairs(servers) do
--    local file = string.format("%s/%s.lua", lsp_dir, name)
--    if vim.fn.filereadable(file) == 1 then
--       local ok, config = pcall(dofile, file)
--       if ok and type(config) == "table" then
--          -- vim.notify("Overriden with "..name,vim.log.levels.WARN)
--          vim.lsp.config(name, config)
--       end
--    end
-- end
-- -- If I find out how to do it we can delete this.
--
-- vim.lsp.enable(servers)

-- local function find_files(folder_path)
--    local lua_files = {}
--    local stat, _= vim.uv.fs_stat(folder_path)
--    if not stat or stat.type ~= 'directory' then
--       return lua_files
--    end
--    local dir_handle = vim.uv.fs_opendir(folder_path)
--    if not dir_handle then
--       return lua_files
--    end
--
--    local entries = vim.uv.fs_readdir(dir_handle)
--    for _, e in ipairs(entries) do
--       local name = e.name
--       vim.notify(name,vim.log.levels.WARN)
--       if e.type == 'file' and name:match("%.lua$") then
--          table.insert(lua_files, e.name:gsub("%.lua",""))
--       end
--    end
--    vim.uv.fs_closedir(dir_handle)
--    return lua_files
-- end

-- local files = find_files(vim.fn.stdpath('config') .. "/lsp")
-- vim.notify(files,vim.log.levels.WARN)
vim.lsp.enable({
   "lua_ls",
   "csharp_ls",
   "powershell_es",
   "clangd", "cmake",
   "csharp_ls",
   "jsonls",
   "pyright",
   "ruff",
   "lemminx",
   -- "rust_analyzer",
})
