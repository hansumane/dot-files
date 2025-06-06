-- NOTE: Use vim-rooter instead of project.nvim, because:
--       1) It doesn't generate neither warnings nor errors;
--       2) It is more flexible;
--       3) It is maintained.
return {
  'airblade/vim-rooter',
  priority = 2000, lazy = false,
  config = function()
    vim.g.rooter_silent_chdir = 1
    -- vim.g.rooter_change_directory_for_non_project_files = 'current'
    vim.g.rooter_patterns = { '.git', '.vi_project_root' }
  end
}
