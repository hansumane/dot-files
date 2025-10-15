return {
  'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    -- { '3rd/image.nvim', opts = {} } -- image support
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      window = {
        mappings = {
          ['E'] = 'expand_all_subnodes',
          ['W'] = 'close_all_subnodes',
          ['h'] = 'navigate_up',
          ['C'] = 'set_root'
        }
      },
      filesystem = { hijack_netrw_behavior = 'open_current' }
    }

    local map = require('mappings').now

    map { mods = 'n', map = '<leader>e',
          cmd = ':Neotree toggle reveal_force_cwd<CR>',
          opts = { silent = true, noremap = true, desc = 'Neotree: Normal' } }

    map { mods = 'n', map = '<leader>/',
          cmd = ':Neotree toggle current reveal_force_cwd<CR>',
          opts = { silent = true, noremap = true, desc = 'Neotree: Fullscreen' } }
  end
}
