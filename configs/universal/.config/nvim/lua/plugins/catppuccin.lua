return {
  enabled = false,
  'catppuccin/nvim', name = 'catppuccin',
  lazy = false, priority = 1300,
  config = function()
    require('catppuccin').setup {
      background = {
        dark = 'mocha',
        light = 'latte'
      },
      custom_highlights = function(colors)
        return {
          TodoBgTODO = { fg = colors.base, bg = colors.flamingo, bold = true },
          TodoFgTODO = { fg = colors.flamingo },
          TodoSignTODO = { link = 'TodoFgTODO' },
        }
      end
    }

    vim.cmd.colorscheme('catppuccin')
  end
}
