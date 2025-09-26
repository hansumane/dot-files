return {
  'hansumane/lackluster.nvim',
  lazy = false, priority = 1300,
  config = function()
    local lackluster = require('lackluster')
    lackluster.setup{}

    local restore_bg = require('config.globals').funcs.restore_bg
    local bg = restore_bg(false)
    if bg ~= 'dark' then
      vim.o.background = 'light'
      restore_bg(true)
    end

    vim.cmd.colorscheme('lackluster-hack')
  end
}
