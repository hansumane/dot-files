return {
  'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      filesystem = {
        hijack_netrw_behavior = 'open_current',
        filtered_items = {
          hide_gitignored = false,
          hide_dotfiles = false,
          never_show = { '.git' },
          hide_by_name = { '.github' }
        }
      },
      window = {
        mappings = {
          ['E'] = 'expand_all_subnodes',
          ['W'] = 'close_all_subnodes',
          ['h'] = 'navigate_up',
          ['C'] = 'set_root'
        }
      }
    }

    local map = require('config.globals').funcs.map

    map { mods = 'n', map = '<leader>e',
          cmd = ':Neotree toggle reveal_force_cwd<CR>',
          opts = { silent = true, noremap = true, desc = 'Neotree: Normal' } }

    map { mods = 'n', map = '<leader>/',
          cmd = ':Neotree toggle current reveal_force_cwd<CR>',
          opts = { silent = true, noremap = true, desc = 'Neotree: Fullscreen' } }
  end
}
