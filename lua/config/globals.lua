vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- No remote plugins used (all plugins are pure Lua). Disable the language-host
-- providers so nvim never probes PATH for them. python3 in particular caused a
-- ~5.5s hang opening python files (ftplugin/python.vim calls has('python3')).
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.keymap.set({ "n", "x", "o" }, "<Space>", "<Leader>", { remap = true, silent = true })

---@diagnostic disable: undefined-field
local sys = vim.loop.os_uname().sysname
local os_name

sys = sys:lower()

if sys:find("linux") then
  os_name = "Linux"
elseif sys:find("darwin") then
  os_name = "Mac"
elseif sys:find("bsd") then
  os_name = "Bsd"
elseif sys:find("win") then
  os_name = "Win"
else
  os_name = "Unknown"
end

vim.g.os = os_name
