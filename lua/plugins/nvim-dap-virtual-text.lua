return {
   "theHamsta/nvim-dap-virtual-text",
   config = true,
   dependencies = {
      "mfussenegger/nvim-dap",
   },
   opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      virt_lines = false,
   },
}
