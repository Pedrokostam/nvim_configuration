return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		lazy = false,
		event = "BufRead",
		branch = "main",
		build = ":TSUpdate",
		---@class TSConfig
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"diff",
				"c_sharp",
				"css",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"luap",
				"vim",
				"markdown",
				"markdown_inline",
				"vimdoc",
				"toml",
				"python",
				"rust",
				"query",
				"regex",
				"powershell",
				"xml",
				"yaml"
			},
		},
		 config = function(_, opts)
      -- install parsers from custom opts.ensure_installed
      if opts.ensure_installed and #opts.ensure_installed > 0 then
        require("nvim-treesitter").install(opts.ensure_installed)
        -- register and start parsers for filetypes
        for _, parser in ipairs(opts.ensure_installed) do
          local filetypes = parser -- In this case, parser is the filetype/language name
          vim.treesitter.language.register(parser, filetypes)

          vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = filetypes,
            callback = function(event)
              vim.treesitter.start(event.buf, parser)
            end,
          })
        end
      end

      -- Auto-install and start parsers for any buffer
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        callback = function(event)
          local bufnr = event.buf
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

          -- Skip if no filetype
          if filetype == "" then
            return
          end

          -- Check if this filetype is already handled by explicit opts.ensure_installed config
          for _, filetypes in pairs(opts.ensure_installed) do
            local ft_table = type(filetypes) == "table" and filetypes or { filetypes }
            if vim.tbl_contains(ft_table, filetype) then
              return -- Already handled above
            end
          end

          -- Get parser name based on filetype
          local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
          if not parser_name then
            return
          end
          -- Try to get existing parser (helpful check if filetype was returned above)
          local parser_configs = require("nvim-treesitter.parsers")
          if not parser_configs[parser_name] then
            return -- Parser not available, skip silently
          end

          local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

          if not parser_installed then
            -- If not installed, install parser synchronously
            require("nvim-treesitter").install({ parser_name }):wait(30000)
          end

          -- let's check again
          parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

          if parser_installed then
            -- Start treesitter for this buffer
            vim.treesitter.start(bufnr, parser_name)
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
    },
    opts = {
      multiwindow = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = {
      {
        "af",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        desc = "Select outer function",
        mode = { "x", "o" },
      },
      {
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end,
        desc = "Select inner function",
        mode = { "x", "o" },
      },
      {
        "ac",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end,
        desc = "Select outer class",
        mode = { "x", "o" },
      },
      {
        "ic",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end,
        desc = "Select inner class",
        mode = { "x", "o" },
      },
      {
        "as",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
        end,
        desc = "Select local scope",
        mode = { "x", "o" },
      },
    },
    ---@module "nvim-treesitter-textobjects"
    opts = { multiwindow = true },
  },
}



		-- auto_install = true,
		-- indent = { enable = true },
		-- highlight = { enable = true },
		-- folds = { enable = true },
		-- A list of parser names, or "all" (the listed parsers MUST always be installed)

		-- Install parsers synchronously (only applied to `ensure_installed`)
		-- sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally

		-- List of parsers to ignore installing (or "all")
		-- ignore_install = { "javascript" },

		---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
		-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

		-- incremental_selection = {
		-- 	enable = true,
		-- 	keymaps = {
		-- 		init_selection = "<CR>",
		-- 		node_incremental = "<CR>",
		-- 		scope_incremental = "<TAB>",
		-- 		node_decremental = "<S-TAB>",
		-- 	}
		-- }
	
	-- -- On Windows, use `gcc` if `cl` is not available, and `gcc` is.
	-- if
	-- 	not vim.env.CC
	-- 	and vim.fn.has("win32") == 1
	-- 	and vim.fn.executable("cl") == 0
	-- 	and vim.fn.executable("gcc") == 1
	-- then
	-- 	vim.env.CC = "gcc"
	-- end
