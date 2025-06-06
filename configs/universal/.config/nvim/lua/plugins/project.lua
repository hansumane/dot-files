return {
  -- 'ahmedkhalf/project.nvim' + fix of vim.lsp.buf_get_clients()
  'Spelis/project.nvim',
  config = function ()
    require('project_nvim').setup {
      patterns = { '.git', '.vi_project_root' }
    }
  end
}
