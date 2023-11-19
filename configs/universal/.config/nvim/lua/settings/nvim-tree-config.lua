local tree_config = function ()
  require'nvim-tree'.setup{
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    view = {
      adaptive_size = true,
    },
  }

  vim.g.loaded_netrw = true
  vim.g.loaded_netrwPlugin = true
  vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>')

  vim.api.nvim_create_autocmd('QuitPre', {
    callback = function ()
      local tree_wins = {}
      local floating_wins = {}
      local wins = vim.api.nvim_list_wins()

      for _, w in ipairs(wins) do
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
        if bufname:match'NvimTree_' ~= nil then
          table.insert(tree_wins, w)
        end
        if vim.api.nvim_win_get_config(w).relative ~= '' then
          table.insert(floating_wins, w)
        end
      end

      if #wins - #floating_wins - #tree_wins == 1 then
        for _, w in ipairs(tree_wins) do
          vim.api.nvim_win_close(w, true)
        end
      end
    end
  })
end

return {
  {
    'nvim-tree/nvim-web-devicons',
    config = true,
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = tree_config,
  },
}
