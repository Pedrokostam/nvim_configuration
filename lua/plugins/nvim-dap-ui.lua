return {
  "rcarriga/nvim-dap-ui",
  config = true,
  keys = {
    {
      "<F4>",
      function()
        require("dapui").toggle({})
      end,
      desc = "Dap UI"
    },
  },
  dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      -- "leoluz/nvim-dap-go",
      -- "mfussenegger/nvim-dap-python",

      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
  },
}
