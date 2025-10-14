--vim.cmd('source ' .. vim.fn.stdpath('config') .. '/config.vim')
require("config.lazy")

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
   vim.opt.shell = shell
   vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
   vim.opt.shellquote = ''
   vim.opt.shellxquote = ''
   vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
   vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
   vim.opt.shellslash = false
end

-- File handling
vim.opt.backup = false                             -- Don't create backup files
vim.opt.writebackup = false                        -- Don't create backup before writing
vim.opt.swapfile = false                           -- Don't create swap files
vim.opt.undofile = true                            -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory
vim.opt.updatetime = 300                           -- Faster completion
vim.opt.timeoutlen = 500                           -- Key timeout duration
vim.opt.ttimeoutlen = 0                            -- Key code timeout
vim.opt.autoread = true                            -- Auto reload files changed outside vim
vim.opt.autowrite = false                          -- Don't auto save

--vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, expr = true })

--vim.api.nvim_create_autocmd("BufWritePre", {
--  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
--  callback = function()
--    vim.cmd("silent! %!clang-format")
--  end,
--})
