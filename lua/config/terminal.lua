require("config.globals")
-- Set shell (vim.g.os comes from globals.lua)
if vim.g.os == "Win" then
   local shell = nil
   if vim.fn.executable("pwsh") == 1 then
      shell = "pwsh"
   else
      shell = "powershell"
   end
   vim.o.shell = shell
   vim.o.shellcmdflag =
   "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSStyle.OutputRendering = 'PlainText';"
   vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
   vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
   vim.o.shellquote = ""
   vim.o.shellxquote = ""
end
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal mode", noremap = true })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { noremap = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { noremap = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { noremap = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { noremap = true })
