return {
  'dhananjaylatkar/cscope_maps.nvim',
  ft = { 'c', 'cpp' },
  config = function()
    require('cscope').setup {
      prefix = '<C-c>',
      cscope = { picker = 'telescope' },
    }
    require('mappings').add { mods = 'n', map = '<C-c><C-g>', cmd = ':Cscope find g<CR>' }
    require('mappings').add { mods = 'n', map = '<C-c><C-r>', cmd = ':Cscope find c<CR>' }
  end
}
