vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local branch = "--branch=stable"
  local filter = "--filter=blob:none"
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", filter, repo, branch, lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

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

require("options")
require("my.func")
require("autocmds")
require("nvchad.autocmds")

vim.schedule(function()
  require "mappings"
end)
