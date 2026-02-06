local dap = require("dap")
local dapui = require("dapui")

-- Setup dap-ui
dapui.setup()

-- C# / .NET configuration
dap.adapters.coreclr = {
  type = 'executable',
  command = vim.fn.stdpath("data") .. '/mason/bin/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

-- Auto-open/close dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Keymaps (optional - add to your mappings file or here)
-- Start/Continue debugging (Shift + F9)
vim.keymap.set('n', '<S-F9>', dap.continue, { desc = "Debug: Start/Continue" })

-- Step Over (F8)
vim.keymap.set('n', '<F8>', dap.step_over, { desc = "Debug: Step Over" })

-- Step Into (F7)
vim.keymap.set('n', '<F7>', dap.step_into, { desc = "Debug: Step Into" })

-- Step Out (Shift + F8)
vim.keymap.set('n', '<S-F8>', dap.step_out, { desc = "Debug: Step Out" })

vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = "Debug: Set Conditional Breakpoint" })
