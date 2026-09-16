---@brief
---
--- https://github.com/razzmatazz/csharp-language-server
---
--- Language Server for C#. Install with:
--- `dotnet tool install --global csharp-ls` or via `:MasonInstall csharp-language-server`.
---
--- Prefers a `.sln`, then a `.csproj`, then `.git` as the workspace root.

local function get_root_dir(bufnr, on_dir)
   local fname = vim.api.nvim_buf_get_name(bufnr)
   local root = vim.fs.root(fname, function(name) return name:match('%.sln$') ~= nil end)
       or vim.fs.root(fname, function(name) return name:match('%.csproj$') ~= nil end)
       or vim.fs.root(fname, '.git')
   on_dir(root)
end

---@type vim.lsp.Config
return {
   cmd = { 'csharp-ls' },
   filetypes = { 'cs' },
   root_dir = get_root_dir,
   init_options = { AutomaticWorkspaceInit = true },
}
