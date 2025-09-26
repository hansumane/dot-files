return {
  'airblade/vim-rooter',
  lazy = false, priority = 1100,
  config = function()
    vim.g.rooter_silent_chdir = 1
    vim.g.rooter_patterns = {
      '.project_root', '.git', '.luarc.json', 'compile_flags.txt'
    }
  end
}
