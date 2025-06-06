return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    require('nvim-web-devicons').setup {}
    require('nvim-tree').setup {
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'
        api.config.mappings.default_on_attach(bufnr)
        require('mappings').now {
          mods = 'n', map = 'C', cmd = api.tree.change_root_to_node,
          opts = { desc = 'nvim-tree: CD', buffer = bufnr,
                   noremap = true, silent = true, nowait = true }
        }
      end,
      view = { adaptive_size = true },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {}
      },
      filters = {
        enable = false
      }
    }

    require('mappings').now { mods = 'n', map = '<leader>e',
                              cmd = ':NvimTreeToggle<CR>',
                              opts = { silent = true } }

    require('autocmds').now {
      name = 'QuitPre',
      data = {
        callback = function()
          local tree_wins = {}
          local floating_wins = {}
          local wins = vim.api.nvim_list_wins()

          for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match('NvimTree_') ~= nil then
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
      }
    }
  end
}
