-- OS detection
local mySysname = vim.loop.os_uname().sysname
local isMac = mySysname == 'Darwin'
local isLinux = mySysname == 'Linux'
local isWin = mySysname:find 'Windows' and true or false
local isWsl = isLinux and vim.loop.os_uname().release:find 'Microsoft' and true or false
-- Set shell
if isWin then
   local shell = nil
   if vim.fn.executable("pwsh") == 1 then
      shell = "pwsh"
   else
      shell = "powershell"
   end
   vim.o.shell=shell
   vim.o.shellcmdflag =
   "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSStyle.OutputRendering = 'PlainText';"
   vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
   vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
   vim.o.shellquote = ""
   vim.o.shellxquote = ""
end
