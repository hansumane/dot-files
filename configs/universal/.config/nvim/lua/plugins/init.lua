return {
  setup = function()
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not vim.uv.fs_stat(lazypath) then
      local branch = '--branch=stable'
      local filter = '--filter=blob:none'
      local repo = 'https://github.com/folke/lazy.nvim.git'
      vim.fn.system { 'git', 'clone', filter, repo, branch, lazypath }
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
        not_loaded = ' ',
      }
    }
  },

  settings = {
    require('plugins.themes').monokai,
    require('plugins.nvim-notify'),
    require('plugins.bufkill'),
    require('plugins.nvim-tree'),
    require('defaults').funcs.get_vars().enable_indentlines and require('plugins.indent-blankline') or {},
    require('plugins.deadcolumn'),
    require('plugins.bufferline'),
    require('plugins.nvim-treesitter'),
    require('plugins.cscope'),
    require('plugins.trouble'),
    require('plugins.telescope'),
    require('plugins.blink'),
    require('plugins.lspconfig'),
    require('plugins.project'),
    require('plugins.nvim-autopairs'),
    require('plugins.gitsigns'),
    require('plugins.editorconfig')
  }
}
