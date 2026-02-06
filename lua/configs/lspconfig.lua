require("nvchad.configs.lspconfig").defaults()

local on_attach = function(_, bufnr)
  vim.keymap.set(
    { "n", "v" },
    "<leader>ca",
    vim.lsp.buf.code_action,
    { buffer = bufnr, desc = "Code actions" }
  )
end

vim.lsp.config.omnisharp = {
  on_attach = on_attach,
  cmd = { 
    vim.fn.stdpath("data") .. "/mason/bin/OmniSharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid())
  },
  filetypes = { "cs" },
  root_markers = { "*.sln", "*.csproj", "omnisharp.json", ".git" },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports = true,
    },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableImportCompletion = true,
    },
  },
}

local servers = { "html", "cssls", "omnisharp" }
vim.lsp.enable(servers)

