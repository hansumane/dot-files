return {
  enabled = false,
  'shortcuts/no-neck-pain.nvim',
  lazy = false,
  config = function()
    require('no-neck-pain').setup {
      width = 130,
      -- buffers = { colors = { background = '#181826' } }, -- catppuccin
      buffers = { colors = { background = '#1e2030' } }, -- tokyonight
      autocmds = {
        enableOnVimEnter = true,
        skipEnteringNoNeckPainBuffer = true
      }
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
