return {
   "ibhagwan/fzf-lua",
   -- optional for icon support
   dependencies = { "nvim-tree/nvim-web-devicons" },
   lazy=false,
   -- or if using mini.icons/mini.nvim
   -- dependencies = { "nvim-mini/mini.icons" },
   opts = {
      fzf_opts = { ['--cycle'] = true },
      oldfiles = { include_current_session = true, },
      previewers = { syntax_limit_b = 1024 * 200, },
   },
   keys = {
      {
         "<leader>,",
         "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
         desc = "Switch Buffer",
      },
      -- { "<leader>:",   "<cmd>FzfLua command_history<cr>",       desc = "Command History" },
      -- find
      {
         "<leader>fb",
         "<cmd>FzfLua buffers<cr>",
         desc = "Buffers",
      },
      { "<leader>fz",  "<cmd>FzfLua zoxide<cr>",                desc = "Zoxide" },
      { "<leader>ff",  "<cmd>FzfLua files<cr>",                 desc = "Find Files (Root Dir)" },
      { "<leader>fG",  "<cmd>FzfLua grep_visual<cr>",           desc = "Grep-files" },
      { "<leader>fr",  "<cmd>FzfLua oldfiles<cr>",              desc = "Recent" },
      -- { '<leader>fh', "<cmd>FzfLua helptags<cr>",                 desc = 'Telescope help tags' },
      -- git
      { "<leader>fgc", "<cmd>FzfLua git_commits<CR>",           desc = "Commits" },
      { "<leader>fgs", "<cmd>FzfLua git_status<CR>",            desc = "Status" },
      { "<leader>fgf", "<cmd>FzfLua git_files<CR>",             desc = "Files" },
      -- search
      { '<leader>f"',  "<cmd>FzfLua registers<cr>",             desc = "Registers" },
      { "<leader>fa",  "<cmd>FzfLua autocommands<cr>",          desc = "Auto Commands" },
      { "<leader>fc",  "<cmd>FzfLua command_history<cr>",       desc = "Command History" },
      { "<leader>fC",  "<cmd>FzfLua commands<cr>",              desc = "Commands" },
      -- { "<leader>fh", "<cmd>FzfLua help_tags<cr>",                 desc = "Help Pages" },
      { "<leader>fD",  "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      { "<leader>fd",  "<cmd>FzfLua diagnostics_document<cr>",  desc = "Document Diagnostics" },
      { "<leader>fj",  "<cmd>FzfLua jumplist<cr>",              desc = "Jumplist" },
      { "<leader>fl",  "<cmd>FzfLua loclist<cr>",               desc = "Location List" },
      { "<leader>fm",  "<cmd>FzfLua marks<cr>",                 desc = "Jump to Mark" },
      { "<leader>fR",  "<cmd>FzfLua resume<cr>",                desc = "Reopen last FzfLua window" },
      { "<leader>fq",  "<cmd>FzfLua quickfix<cr>",              desc = "Quickfix List" },
      { "<leader>fhh", "<cmd>FzfLua highlights<cr>",            desc = "Search Highlight Groups" },
      { "<leader>fhk", "<cmd>FzfLua keymaps<cr>",               desc = "Key Maps" },
      { "<leader>fhm", "<cmd>FzfLua man_pages<cr>",             desc = "Man Pages" },
   }
}
