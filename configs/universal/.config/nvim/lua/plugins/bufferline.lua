return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup()
    require('mappings').add { mods = 'n', map = '<S-h>', cmd = ':BufferLineCyclePrev<CR>' }
    require('mappings').add { mods = 'n', map = '<S-l>', cmd = ':BufferLineCycleNext<CR>' }
    require('mappings').add { mods = 'n', map = '<S-n>', cmd = ':BufferLineMovePrev<CR>' }
    require('mappings').add { mods = 'n', map = '<S-m>', cmd = ':BufferLineMoveNext<CR>' }
  end
}
