require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>=", ":NvimTreeResize +5<CR>", { desc = "NvimTree wider" })
map("n", "<leader>-", ":NvimTreeResize -5<CR>", { desc = "NvimTree narrower" })

-- Keymap for finding references in Neovim
vim.api.nvim_set_keymap('n', '<Leader>rf', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })

-- 1. LSP Mappings: Restart LSP
map('n', '<leader>rs', ':LspRestart<CR>', opts)  -- Restart LSP server

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
