return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        xml = { "xmlformatter" },
      },
      formatters = {
        xmlformatter = {
          command = vim.fn.stdpath("data") .. "/mason/bin/xmlformat",
          args = {"--indent", "2", "--overwrite", "-"},
          stdin = true,
        },
      },
      log_level = vim.log.levels.DEBUG,
      notify_on_error = true,
    },
  },
}
