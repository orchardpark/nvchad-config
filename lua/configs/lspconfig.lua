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
  -- Add handlers to suppress initialization warnings
  handlers = {
    ["window/logMessage"] = function(err, result, ctx, config)
      -- Filter out the "before initialization" warnings
      if result and result.message then
        if result.message:match("before initialization was completed") or
           result.message:match("INVALID_SERVER_MESSAGE") then
          return
        end
      end
      -- Pass through other messages to default handler
      vim.lsp.handlers["window/logMessage"](err, result, ctx, config)
    end,
  },
}

local servers = { "html", "cssls", "omnisharp" }
vim.lsp.enable(servers)
