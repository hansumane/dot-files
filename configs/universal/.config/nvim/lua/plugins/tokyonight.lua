return {
  'folke/tokyonight.nvim',
  lazy = false, priority = 1300,
  config = function()
    require('tokyonight').setup{}
    vim.cmd.colorscheme('tokyonight')
  end
}
