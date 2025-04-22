-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local pid = vim.fn.getpid()
local map = vim.keymap.set;

local on_attach = function(client, bufnr)

  -- Keybindings for useful LSP functions
  map('n', '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap=true, silent=false, desc="Go to definition"})
  map('n', '<Leader>gk', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap=true, silent=false, desc="Show documentation"})
  map('n', '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap=true, silent=false, desc="Go to implementation"})
  map('n', '<Leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap=true, silent=false, desc="Rename"})
  map('n', '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap=true, silent=false, desc="Find references"})
  map('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap=true, silent=false, desc="Code actions"})
  map('n', '<Leader>[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap=true, silent=false, desc="Previou diagnostic"})
  map('n', '<Leader>]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap=true, silent=false, desc="Next diagnostic"})
end

lspconfig.omnisharp.setup({
  filetypes = { "cs", "vb" },
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) },
  on_attach=on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

lspconfig.basedpyright.setup({
    on_attach = function(client, bufnr)
        print("BasedPyright LSP attached!")
    end
})

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  cmd = { "typescript-language-server", "--stdio" }
}

