local config = function ()
  require'nvim-treesitter.configs'.setup{
    ensure_installed = {
      'lua', 'luadoc',
      'vim', 'vimdoc',
      'bash', 'ssh_config',
      'c', 'cpp', 'python', 'rust',
      'make', 'cmake', 'json', 'toml', 'yang',
      'gitcommit', 'gitignore',
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
    },
  }
end

return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = config,
}
