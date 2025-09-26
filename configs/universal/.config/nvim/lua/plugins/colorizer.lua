return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup {
      [ 'vim'  ] = { RGB = false, RRGGBB = true, names = false },
      [ 'conf' ] = { RGB = false, RRGGBB = true, names = false },
      [ 'bash' ] = { RGB = false, RRGGBB = true, names = false },
      [ 'tmux' ] = { RGB = false, RRGGBB = true, names = false },
    }
  end
}
