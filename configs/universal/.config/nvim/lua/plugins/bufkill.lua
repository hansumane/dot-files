-- required to switch to _actual_ buffer instead of nvim-tree on :bd
return {
  'qpkorr/vim-bufkill',
  config = function()
    require('mappings').add { mods = 'n', map = '<leader>c', cmd = ':BD<CR>' }
  end
}
