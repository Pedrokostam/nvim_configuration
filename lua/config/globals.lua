vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.o.showtabline = 1
-- vim.o.tabline = "%!v:lua.MyTabLine()"
--
-- function MyTabLine()
--    local s = ""
--    for i = 1, vim.fn.tabpagenr("$") do
--       local winnr = vim.fn.tabpagewinnr(i)
--       local buflist = vim.fn.tabpagebuflist(i)
--       local bufnr = buflist[winnr]
--       local bufname = vim.fn.bufname(bufnr)
--       if vim.bo.filetype == "oil" then
--          bufname = vim.fn.fnamemodify(require('oil').get_current_dir(i-1), ':t')
--       end
--
--       local label = bufname == "" and "[No Name]" or vim.fn.fnamemodify(bufname, ":t")
--       if i == vim.fn.tabpagenr() then
--          s = s .. "%#TabLineSel#"
--       else
--          s = s .. "%#TabLine#"
--       end
--       s = s .. "%" .. i .. "T " .. label .. " "
--    end
--    s = s .. "%#TabLineFill#%T"
--    vim.notify(s, vim.log.levels.WARN)
--    return s
-- end
