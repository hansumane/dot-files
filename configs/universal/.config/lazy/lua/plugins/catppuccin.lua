return {
  'catppuccin/nvim', name = 'catppuccin',
  lazy = false, priority = 1200,
  config = function()
    require('catppuccin').setup {
      background = {
        dark = 'mocha',
        light = 'latte'
      }
    }
    vim.cmd.colorscheme('catppuccin')
  end
}
