return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup {
      [ 'sh'   ] = { RGB = false, RRGGBB = true, names = false },
      [ 'lua'  ] = { RGB = false, RRGGBB = true, names = false },
      [ 'vim'  ] = { RGB = false, RRGGBB = true, names = false },
      [ 'conf' ] = { RGB = false, RRGGBB = true, names = false },
    }
  end
}
