vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "


-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- load luasnip
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.axaml",
    command = "set filetype=xml"
})
require'luasnip.loaders.from_lua'.load({ paths = "~/.config/nvim/LuaSnip" })

-- folding
vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "#region,#endregion"

-- debug point
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.cmd('highlight DapBreakpoint guifg=#E06C75 gui=bold')

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
