return {
  enabled = false,
  'rebelot/kanagawa.nvim',
  lazy = false, priority = 1300,
  config = function()
    require('kanagawa').setup {
      compile = false,
      theme = 'wave',
      background = {
          dark = 'wave',
          light = 'lotus'
      }
    }

    vim.o.background = require('config.globals').funcs.restore_bg(false)
    vim.cmd.colorscheme('kanagawa')
  end
}
