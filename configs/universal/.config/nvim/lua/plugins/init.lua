return {
  setup = function()
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not vim.uv.fs_stat(lazypath) then
      local branch = '--single-branch' -- '--branch=stable'
      local filter = '--filter=blob:none'
      local repo = 'https://github.com/folke/lazy.nvim.git'
      vim.fn.system { 'git', 'clone', filter, branch, repo, lazypath }
    end
    vim.opt.rtp:prepend(lazypath)
  end,

  lazy_settings = {
    defaults = { lazy = false },
    ui = {
      icons = {
        ft = ' ',
        lazy = '󰂠 ',
        loaded = ' ',
        not_loaded = ' '
      }
    }
  },

  settings = {
    require('plugins.rooter'),
    require('plugins.themes').monokai,
    require('defaults').funcs.get_vars().enable_indentlines and require('plugins.ibl').plugin or {},
    require('plugins.editorconfig'),
    require('plugins.deadcolumn'),
    require('plugins.bufferline'),
    require('plugins.treesitter'),
    require('plugins.colorizer'),
    -- lazy plugins:
    require('plugins.noice'),
    require('plugins.lspconfig'),
    require('plugins.trouble'),
    require('plugins.nvim-tree'),
    require('plugins.telescope'),
    require('plugins.cscope_maps'),
    require('plugins.todo-comments'),
    require('plugins.blink'),
    require('plugins.autopairs'),
    require('plugins.gitsigns'),
    require('plugins.toggleterm'),
  }
}
