-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local pid = vim.fn.getpid()

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = false }

  -- Keybindings for useful LSP functions
  buf_set_keymap('n', '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)        -- Go to definition
  buf_set_keymap('n', '<Leader>gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)             -- Show documentation
  buf_set_keymap('n', '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)   -- Go to implementation
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)   -- Rename
  buf_set_keymap('n', '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)       -- Find references
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts) -- Code actions
  buf_set_keymap('n', '<Leader>[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts) -- Previous diagnostic
  buf_set_keymap('n', '<Leader>]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts) -- Next diagnostic
end

lspconfig.omnisharp.setup({
  filetypes = { "cs", "vb", "xml", "xaml" },
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) },
  on_attach=on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
})



