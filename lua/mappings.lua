require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local dap = require("dap")

map("n", "<Leader>dt", dap.toggle_breakpoint, {desc="Toggle breakpoint"})
map("n", "<Leader>dc", dap.continue, {desc="Continue executing"})
-- Step over
map("n", "<Leader>do", dap.step_over, {desc = "Step over"})

-- Step into
map("n", "<Leader>di", dap.step_into, {desc = "Step into"})

-- Step out
map("n", "<Leader>dO", dap.step_out, {desc = "Step out"})

-- Open REPL
map("n", "<Leader>dr", dap.repl.open, {desc = "Open REPL"})

-- Evaluate expression
map("n", "<Leader>de", require("dap.ui.widgets").hover, {desc = "Evaluate expression"})
map("v", "<Leader>de", function()
  require("dap.ui.widgets").visual_hover()
end, {desc = "Evaluate expression (visual)"})

-- Restart debugger
map("n", "<Leader>drt", dap.restart, {desc = "Restart debugger"})

-- Terminate debugging session
map("n", "<Leader>dq", dap.terminate, {desc = "Terminate debugging session"})

-- List breakpoints
map("n", "<Leader>dbl", function()
  require("dap.ui.widgets").sidebar(require("dap.ui.widgets").scopes).open()
end, {desc = "List breakpoints"})
