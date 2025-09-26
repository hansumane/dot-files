return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    require('gitsigns').setup()

    local map = require('config.globals').funcs.map

    map { mods = 'n', map = '<leader>gb', cmd = ':Gitsigns blame<CR>',
          opts = { silent = true, desc = 'Gitsigns: Blame' } }

    map { mods = 'n', map = '<leader>gl', cmd = ':Gitsigns blame_line<CR>',
         opts = { silent = true, desc = 'Gitsigns: Blame Line' } }

    map { mods = { 'n', 'x' }, map = ']g', cmd = ':Gitsigns next_hunk<CR>',
          opts = { silent = true, desc = 'Gitsigns: Go to Next Hunk' } }

    map { mods = { 'n', 'x' }, map = '[g', cmd = ':Gitsigns prev_hunk<CR>',
          opts = { silent = true, desc = 'Gitsigns: Go to Previous Hunk' } }
  end
}
