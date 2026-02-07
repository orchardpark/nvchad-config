require "nvchad.mappings"
local opts = { noremap = true, silent = true }
local function desc_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- add yours here

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
