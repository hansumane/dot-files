return {
  'gbprod/yanky.nvim',
  dependencies = { 'folke/snacks.nvim' },
  event = 'VeryLazy',
  config = function()
    require('yanky').setup{}

    local map = require('config.globals').funcs.map

    map { mods = { 'n', 'x' }, map = 'p',
          opts = { silent = true, desc = 'Yanky: Put After' },
          cmd = '<Plug>(YankyPutAfter)' }
    map { mods = { 'n', 'x' }, map = 'P',
          opts = { silent = true, desc = 'Yanky: Put Before' },
          cmd = '<Plug>(YankyPutBefore)' }
    map { mods = { 'n', 'x' }, map = 'gp',
          opts = { silent = true, desc = 'Yanky: G Put After' },
          cmd = '<Plug>(YankyGPutAfter)' }
    map { mods = { 'n', 'x' }, map = 'gP',
          opts = { silent = true, desc = 'Yanky: G Put Before' },
          cmd = '<Plug>(YankyGPutBefore)' }

    map { mods = 'n', map = '<C-n>',
          opts = { silent = true, desc = 'Yanky: Next Entry' },
          cmd = '<Plug>(YankyNextEntry)' }
    map { mods = 'n', map = '<C-p>',
          opts = { silent = true, desc = 'Yanky: Previous Entry' },
          cmd = '<Plug>(YankyPreviousEntry)' }

    map { mods = 'n', map = '<leader>p',
          opts = { silent = true, desc = 'Yanky: Snacks picker' },
          cmd = Snacks.picker.yanky }
  end
}
