return {
  'catppuccin/nvim', name = 'catppuccin',
  lazy = false, priority = 1200,
  config = function()
    require('catppuccin').setup {
      background = {
        dark = 'mocha',
        light = 'latte'
      },
      custom_highlights = function(colors)
        return {
          TodoBgTODO = { fg = '#1e1e2f', bg = '#f2cdce', bold = true },
          TodoFgTODO = { fg = '#f2cdce' },
          TodoSignTODO = { link = 'TodoFgTODO' },
        }
      end
    }

    vim.cmd.colorscheme('catppuccin')
  end
}
