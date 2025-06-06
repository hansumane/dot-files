return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      highlight = { enable = true },
      ignore_install = { 'make', 'tmux' },
      ensure_installed = {
        'c', 'python', 'vimdoc', 'comment',
        'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
        -- for noice:
        'vim', 'regex', 'lua', 'bash', 'markdown', 'markdown_inline'
      }
    }
  end
}
