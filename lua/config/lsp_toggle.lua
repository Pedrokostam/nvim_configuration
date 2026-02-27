-- Function to toggle LSP for the current buffer
local function toggle_lsp()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

  if #clients > 0 then
    -- If there are active clients for the buffer, stop them
    for _, client in ipairs(clients) do
      vim.lsp.stop_client(client.id)
    end
    vim.notify("LSP stopped for the current buffer.", vim.log.levels.INFO)
  else
    -- If there are no active clients, restart LSP by reloading the buffer
    vim.cmd('edit')
    vim.notify("LSP started for the current buffer.", vim.log.levels.INFO)
  end
end

-- Keymap to toggle LSP
-- Change '<leader>l' to your preferred keybinding
vim.keymap.set('n', '<leader>lt', toggle_lsp, { noremap = true, silent = true, desc = "Toggle LSP for buffer" })

