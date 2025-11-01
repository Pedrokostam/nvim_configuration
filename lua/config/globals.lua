vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
