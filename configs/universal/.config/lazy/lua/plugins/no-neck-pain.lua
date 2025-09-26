return {
  'shortcuts/no-neck-pain.nvim',
  lazy = false,
  config = function()
    require('no-neck-pain').setup {
      width = 130,
      buffers = { blend = -0.9 }
    }

    local map = require('config.globals').funcs.map

    map { mods = 'n', map = '<leader>nn',
          opts = { desc = 'NoNeckPain: Toggle' },
          cmd = ':NoNeckPain<CR>' }

    map { mods = 'n', map = '<leader>ns',
          opts = { desc = 'NoNeckPain: ScratchPad' },
          cmd = ':NoNeckPainScratchPad<CR>' }
  end
}
