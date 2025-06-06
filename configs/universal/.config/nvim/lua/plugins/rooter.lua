return {
  'airblade/vim-rooter',
  priority = 2000 - 0, lazy = false,
  config = function()
    vim.g.rooter_silent_chdir = 1
    vim.g.rooter_patterns = { '.git', '.vi_project_root' }
    -- vim.g.rooter_change_directory_for_non_project_files = 'current'
  end
}
