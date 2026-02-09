require "nvchad.mappings"
local opts = { noremap = true, silent = true }
local function desc_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>=", ":NvimTreeResize +5<CR>", { desc = "NvimTree wider" })
map("n", "<leader>-", ":NvimTreeResize -5<CR>", { desc = "NvimTree narrower" })

-- Keymap for finding references in Neovim
map('n', '<Leader>rf', '<cmd>lua vim.lsp.buf.references()<CR>',opts)

-- 1. LSP Mappings: Restart LSP
map('n', '<leader>rs', ':LspRestart<CR>', opts)

map('t', '<Esc>', '<C-\\><C-n>', opts)

-- Cycle to the next buffer (similar to Alt+Tab)
map('n', '<leader>bn', ':bnext<CR>',opts)

-- Cycle to the previous buffer (similar to Alt+Shift+Tab)
map('n', '<leader>bp', ':bprev<CR>',opts)


map('n', '<leader>nl', '<C-w>l', desc_opts('Move to right window'))
map('n', '<leader>nh', '<C-w>h', desc_opts('Move to left window'))


-- DAP (Debug Adapter Protocol) - Leader-based shortcuts

-- Breakpoints
map('n', '<leader>db', function() require('dap').toggle_breakpoint() end, desc_opts('Toggle Breakpoint'))
map('n', '<leader>dBc', function() 
  require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
end, desc_opts('Conditional Breakpoint'))
map('n', '<leader>dBh', function()
  require('dap').set_breakpoint(nil, vim.fn.input('Hit count: '))
end, desc_opts('Breakpoint with Hit Count'))
map('n', '<leader>dBl', function()
  require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, desc_opts('Log Point'))

map('n', '<leader>da', function() 
  require('dap').continue()
  require('dap').set_configuration({
    type = "coreclr",
    request = "attach",
    processId = require('dap.utils').pick_process,
  })
end, desc_opts('Attach to Process'))

-- Debug Control
map('n', '<leader>dc', function() require('dap').continue() end, desc_opts('Continue/Start Debug'))
map('n', '<leader>dt', function() require('dap').terminate() end, desc_opts('Terminate Debug'))
map('n', '<leader>dr', function() require('dap').restart() end, desc_opts('Restart Debug'))
map('n', '<leader>dp', function() require('dap').pause() end, desc_opts('Pause Debug'))

-- Stepping
map('n', '<leader>di', function() require('dap').step_into() end, desc_opts('Step Into'))
map('n', '<leader>do', function() require('dap').step_over() end, desc_opts('Step Over'))
map('n', '<leader>dO', function() require('dap').step_out() end, desc_opts('Step Out'))
map('n', '<leader>drc', function() require('dap').run_to_cursor() end, desc_opts('Run to Cursor'))

-- UI & Evaluation
map('n', '<leader>du', function() require('dapui').toggle() end, desc_opts('Toggle Debug UI'))
map('n', '<leader>de', function() require('dapui').eval() end, desc_opts('Evaluate Expression'))
map('v', '<leader>de', function() require('dapui').eval() end, desc_opts('Evaluate Selection'))
map('n', '<leader>dh', function() require('dap.ui.widgets').hover() end, desc_opts('Hover Variables'))
map('n', '<leader>dE', function()
  local expr = vim.fn.input('DAP Eval > ')
  if expr ~= '' then
    require('dapui').eval(expr)
  end
end, { desc = 'DAP eval (prompt)' })


-- REPL
map('n', '<leader>drepl', function() require('dap').repl.toggle() end, desc_opts('Toggle REPL'))

-- Other
map('n', '<leader>dl', function() require('dap').run_last() end, desc_opts('Run Last Debug Config'))
map('n', '<leader>dg', function() require('dap').goto_() end, desc_opts('Go to Current Execution Point'))
