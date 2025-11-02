return {
   'mrcjkb/rustaceanvim',
   version = '^6', -- Recommended
   lazy = false,   -- This plugin is already lazy
   ft = "rust",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
   },
   -- opts = {
   --    dap = {
   --       program = function()
   --          configuration = {}
   --       end
   --    }
   -- },
   opts = {
    dap = {
      configuration = {
        {
          name = "Debug",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          initCommands = {
            'command script import "' ..
            vim.fn.stdpath("data") .. '/resources/rust_prettifier_for_lldb.py"',
          },
        },
      },
    },
  },
   config = function(_, opts)
      vim.g.rustaceanbim = {
         server = {
            on_attach = function(client, bufnr)
               local success, _ = pcall(vim.lsp.inlay_hint.enable, true)
               if not success then
                  vim.lsp.inlay_hint.enable(true)
               end
            end,
            default_settings = {
               -- rust-analyzer language server configuration
               ["rust-analyzer"] = {
                  cargo = {
                     features = "all",
                  },
               },
            },
         }
      }
   end

}
