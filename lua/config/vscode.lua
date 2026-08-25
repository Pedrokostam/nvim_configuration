-- Overrides for vscode-neovim. Loaded after config.keymaps, so these win.
--
-- Instead of hardcoding lhs keys, we read the keymaps config.keymaps already
-- set and re-point them by *behavior*: an LSP callback or a recognizable rhs
-- string maps to a VS Code command. Rebind something in config.keymaps and the
-- override follows the new key automatically -- nothing to keep in sync here.
local vscode = require("vscode")

-- options.lua forces a block cursor in Insert (i-ci-ve:block), which makes
-- Insert indistinguishable from Normal. VS Code has no statusline mode text,
-- so the cursor shape is the only indicator -- give Insert a vertical bar here.
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- callback identity -> VS Code action. Matches maps set as a direct function
-- reference, e.g. vim.keymap.set("n", "K", vim.lsp.buf.hover).
local by_callback = {
   [vim.lsp.buf.hover]           = "editor.action.showHover",
   [vim.lsp.buf.signature_help]  = "editor.action.triggerParameterHints",
   [vim.lsp.buf.declaration]     = "editor.action.revealDeclaration",
   [vim.lsp.buf.definition]      = "editor.action.revealDefinition",
   [vim.lsp.buf.type_definition] = "editor.action.goToTypeDefinition",
   [vim.lsp.buf.references]      = "editor.action.goToReferences",
   [vim.lsp.buf.implementation]  = "editor.action.goToImplementation",
   [vim.lsp.buf.code_action]     = "editor.action.quickFix",
   [vim.lsp.buf.rename]          = "editor.action.rename",
   [vim.lsp.buf.format]          = "editor.action.formatDocument",
   [vim.diagnostic.open_float]   = "editor.action.marker.next",
   [vim.diagnostic.goto_next]    = "editor.action.marker.next",
   [vim.diagnostic.goto_prev]    = "editor.action.marker.prev",
}

-- Ordered Lua patterns matched against a lower-cased rhs string. First hit wins,
-- so put the more specific rules first.
local by_rhs = {
   { "vsplit.*lsp%.buf%.definition", "editor.action.revealDefinitionAside" },
   { "split.*lsp%.buf%.definition",  "editor.action.revealDefinitionAside" },
   { "lsp%.buf%.definition",         "editor.action.revealDefinition" },
   { "^<cmd>vsplit",                 "workbench.action.splitEditor" },
   { "^<cmd>split",                  "workbench.action.splitEditorDown" },
   { "^<c%-w>h$",                    "workbench.action.navigateLeft" },
   { "^<c%-w>j$",                    "workbench.action.navigateDown" },
   { "^<c%-w>k$",                    "workbench.action.navigateUp" },
   { "^<c%-w>l$",                    "workbench.action.navigateRight" },
   { "<c%-x><c%-o>",                 "editor.action.triggerSuggest" },
}

local function resolve(m)
   if m.callback and by_callback[m.callback] then
      return by_callback[m.callback]
   end
   if m.rhs and m.rhs ~= "" then
      local rhs = m.rhs:lower()
      for _, rule in ipairs(by_rhs) do
         if rhs:match(rule[1]) then return rule[2] end
      end
   end
   return nil
end

for _, mode in ipairs({ "n", "i", "v", "x", "o" }) do
   for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
      local action = resolve(m)
      if action then
         vim.keymap.set(mode, m.lhs, function() vscode.action(action) end,
            { silent = true, desc = "vscode: " .. action })
      end
   end
end

-- fzf-lua's keymaps live in its plugin spec, which never loads under VS Code
-- (we return before lazy). Re-create the useful pickers against VS Code's own.
-- Not 1:1 -- these open the nearest-equivalent VS Code UI.
local fzf_maps = {
   -- grep / symbols
   { "<leader>fgg", "workbench.action.findInFiles",              "Grep files (Search panel)" },
   { "<leader>fgG", "actions.find",                              "Find in current file" },
   { "<leader>fds", "workbench.action.gotoSymbol",               "Document symbols" },
   { "<leader>fdS", "workbench.action.showAllSymbols",           "Workspace symbols" },
   -- files / buffers / recent
   { "<leader>ff",  "workbench.action.quickOpen",                "Find files" },
   { "<leader>,",   "workbench.action.showAllEditorsByMostRecentlyUsed", "Switch buffer (open editors)" },
   { "<leader>fr",  "workbench.action.openRecent",               "Recent" },
   -- LSP navigation
   { "<leader>fdd", "editor.action.revealDefinition",            "Definitions" },
   { "<leader>fdD", "editor.action.revealDeclaration",           "Declarations" },
   { "<leader>fdr", "editor.action.goToReferences",              "References" },
   { "<leader>fda", "editor.action.quickFix",                    "Code actions" },
   -- diagnostics / quickfix -> Problems panel
   { "<leader>fdg", "workbench.actions.view.problems",           "Document diagnostics" },
   { "<leader>fdG", "workbench.actions.view.problems",           "Workspace diagnostics" },
   { "<leader>fq",  "workbench.actions.view.problems",           "Quickfix (Problems)" },
}
for _, m in ipairs(fzf_maps) do
   vim.keymap.set("n", m[1], function() vscode.action(m[2]) end, { silent = true, desc = m[3] })
end
