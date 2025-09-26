return {
  'folke/trouble.nvim',
  event = 'VeryLazy',
  config = function()
    local funcs = require('config.globals').funcs

    require('trouble').setup{}

    funcs.map { mods = 'n', map = '<leader>lx',
                opts = { silent = true, desc = 'Trouble: Diagnostics' },
                cmd = ':Trouble diagnostics toggle focus=true filter.buf=0<CR>' }
  end
}
