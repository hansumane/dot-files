return {
  enabled = false,
  'hansumane/neo-tree.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      filesystem = {
        hijack_netrw_behavior = 'open_current',
        filtered_items = {
          never_show = { '.git' },
          hide_gitignored = false,
          hide_dotfiles = false
        }
      },
      window = {
        mappings = {
          ['E'] = 'expand_all_subnodes',
          ['W'] = 'close_all_subnodes',
          ['h'] = 'navigate_up',
          ['C'] = 'set_root'
        },
        fuzzy_finder_mappings = {
          ['<C-j>'] = 'move_cursor_down',
          ['<C-k>'] = 'move_cursor_up'
        }
      }
    }

    local map = require('config.globals').funcs.map

    map { mods = 'n', map = '<leader>e',
          cmd = ':Neotree toggle current reveal_force_cwd<CR>',
          opts = { silent = true, noremap = true, desc = 'Neotree: Force CWD' } }

    map { mods = 'n', map = '<leader>f',
          cmd = function()
            vim.cmd((':Neotree toggle current dir=%s reveal_file=%s'):format(
              vim.fn.expand('%:p:h'), vim.fn.expand('%:p')))
          end,
          opts = { silent = true, noremap = true, desc = 'Neotree: File Path' } }
  end
}
