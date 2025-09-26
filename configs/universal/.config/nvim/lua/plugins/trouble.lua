return {
  'folke/trouble.nvim',
  event = 'VeryLazy',
  config = function()
    require('trouble').setup{}

    local map = require('config.globals').funcs.map

    map { mods = 'n', map = '<leader>lx',
          opts = { silent = true, desc = 'Trouble: Diagnostics' },
          cmd = ':Trouble diagnostics toggle focus=true filter.buf=0<CR>' }
  end
}
