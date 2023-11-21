local function config ()
  require'lualine'.setup{
    options = {
      icons_enabled = true,
      theme = 'catppuccin',
      component_separators = {
        left = '|',
        right = '|',
      },
      section_separators = {
        left = '',
        right = '',
      },
    },
    sections = {
      lualine_x = {
        'encoding',
        {
          'fileformat',
          symbols = {
            unix = 'U',
            dos = 'W',
            mac = 'A',
          },
        },
        'filetype'
      },
    },
  }
end

return {
  'nvim-lualine/lualine.nvim',
  config = config,
}
