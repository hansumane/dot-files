return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function ()
    require('gitsigns').setup()

    local map = require('mappings').now
    map { mods = 'n', map = '<leader>gb', cmd = ':Gitsigns blame<CR>', opts = { silent = true } }
    map { mods = 'n', map = '<leader>gj', cmd = ':Gitsigns next_hunk<CR>', opts = { silent = true } }
    map { mods = 'n', map = '<leader>gk', cmd = ':Gitsigns prev_hunk<CR>', opts = { silent = true } }
  end
}
