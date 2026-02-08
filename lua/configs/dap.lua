local dap = require('dap')
local dapui = require('dapui')

-- Define breakpoint signs with better visibility
vim.fn.sign_define('DapBreakpoint', {
  text = '🔴',
  texthl = 'DapBreakpoint',
  linehl = '',
  numhl = 'DapBreakpoint'
})

vim.fn.sign_define('DapBreakpointCondition', {
  text = '🟡',
  texthl = 'DapBreakpoint',
  linehl = '',
  numhl = 'DapBreakpoint'
})

vim.fn.sign_define('DapBreakpointRejected', {
  text = '🔵',
  texthl = 'DapBreakpoint',
  linehl = '',
  numhl = 'DapBreakpoint'
})

vim.fn.sign_define('DapLogPoint', {
  text = '📝',
  texthl = 'DapLogPoint',
  linehl = '',
  numhl = 'DapLogPoint'
})

vim.fn.sign_define('DapStopped', {
  text = '▶️',
  texthl = 'DapStopped',
  linehl = 'DapStoppedLine',
  numhl = 'DapStopped'
})

-- Define highlight groups for breakpoints
vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' })
vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })
vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e4d3d' })

-- Setup DAP UI
dapui.setup()

-- Setup virtual text
require('nvim-dap-virtual-text').setup()

-- Auto-open UI when debugging starts
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- C# / .NET Core adapter configuration
dap.adapters.coreclr = {
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
  args = {'--interpreter=vscode'}
}

-- C# / .NET Core debug configurations
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      -- Auto-find the DLL in bin/Debug
      local cwd = vim.fn.getcwd()
      local dll_path = vim.fn.input('Path to dll: ', cwd .. '/bin/Debug/', 'file')
      return dll_path
    end,
    cwd = '${workspaceFolder}',
    env = {
      ASPNETCORE_ENVIRONMENT = "Development",
    },
  },
  {
    type = "coreclr",
    name = "attach - netcoredbg",
    request = "attach",
    processId = require('dap.utils').pick_process,
  },
}
