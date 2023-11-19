return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 100,
  config = function()
    vim.opt.background = 'dark'
    require'catppuccin'.setup{flavour = 'mocha'}
    vim.cmd.colorscheme'catppuccin'
  end
}
