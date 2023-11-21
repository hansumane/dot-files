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
      lualine_y = {
        function ()
          local shift = vim.opt.shiftwidth:get()
          local tabst = vim.opt.tabstop:get()
          local expand = vim.opt.expandtab:get()
          local result = shift .. '/' .. tabst .. '-'
          if expand then
            result = result .. 'S'
          elseif shift ~= tabst then
            result = result .. 'M'
          else
            result = result .. 'T'
          end
          return result
        end
      },
    },
  }
end

return {
  'nvim-lualine/lualine.nvim',
  config = config,
}
