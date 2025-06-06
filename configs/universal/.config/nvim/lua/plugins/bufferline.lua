return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup()

    local map = require('mappings').now
    map { mods = 'n', map = 'H', cmd = ':BufferLineCyclePrev<CR>', opts = { silent = true } }
    map { mods = 'n', map = 'L', cmd = ':BufferLineCycleNext<CR>', opts = { silent = true } }
    map { mods = 'n', map = 'N', cmd = ':BufferLineMovePrev<CR>', opts = { silent = true } }
    map { mods = 'n', map = 'M', cmd = ':BufferLineMoveNext<CR>', opts = { silent = true } }
  end
}
