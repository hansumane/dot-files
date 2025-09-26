-- FIXME: vim.tbl_flatten is deprecated
return {
  enabled = false,
  'norcalli/nvim-colorizer.lua',
  event = 'VeryLazy',
  config = function()
    require('colorizer').setup {
      [ 'vim'  ] = { RGB = false, RRGGBB = true, names = false },
      [ 'conf' ] = { RGB = false, RRGGBB = true, names = false },
      [ 'bash' ] = { RGB = false, RRGGBB = true, names = false },
      [ 'tmux' ] = { RGB = false, RRGGBB = true, names = false },
    }
  end
}
