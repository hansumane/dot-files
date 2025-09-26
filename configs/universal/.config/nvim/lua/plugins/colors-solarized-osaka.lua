return {
  enabled = false,
  'craftzdog/solarized-osaka.nvim',
  lazy = false, priority = 1300,
  config = function()
    require('solarized-osaka').setup {
      -- sidebars: darker background on sidebar-like windows
      -- sidebars = { 'qf', 'help', 'vista_kind', 'terminal', 'packer' },
      transparent = true -- do not set background color
    }
    vim.o.background = require('config.globals').funcs.restore_bg(false)
    vim.cmd.colorscheme('solarized-osaka')
  end,
}
