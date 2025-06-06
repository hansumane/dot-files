return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      highlight = { enable = true },
      ignore_install = { 'make', 'tmux' },
      ensure_installed = {
        'c', 'bash', 'lua', 'python', 'vim', 'vimdoc', 'comment', 'markdown',
        'markdown_inline', 'git_config', 'git_rebase', 'gitattributes',
        'gitcommit', 'gitignore'
      }
    }
  end
}
