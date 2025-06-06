return {
  'lewis6991/gitsigns.nvim',
  config = function ()
    require('gitsigns').setup()

    -- TODO: add mappings to navigate through hunks
    local map = require('mappings').add
    map { mods = 'n', map = '<leader>gb', cmd = ':Gitsigns blame<CR>',
          opts = { silent = true } }
  end
}
