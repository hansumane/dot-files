-- TODO: https://github.com/nvim-telescope/telescope-live-grep-args.nvim.git

return {
  enabled = false,
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  config = function()
    local actions = require('telescope.actions')

    local telescope_delete_buffer = function(prompt_bufnr)
      require('telescope.actions.state')
        .get_current_picker(prompt_bufnr)
        :delete_selection(function(selection)
          local ok = pcall(Snacks.bufdelete, { buf = selection.bufnr })
          return ok
        end)
    end

    require('telescope').setup {
      defaults = {
        initial_mode = 'normal',
        sorting_strategy = 'ascending',
        mappings = {
          -- <C-q> to open search results in a quickfix
          n = {
            ['q'] = actions.close,
            ['<C-g>'] = actions.close
          },
          i = {
            ['<C-g>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous
          }
        },
        layout_config = {
          preview_width = 0.62,
          width = { padding = 0.00 }, -- width = 1.0, -- doesn't work
          height = { padding = 0.00 }, -- height = 1.0, -- doesn't work
          prompt_position = 'top'
        }
      },
      pickers = {
        find_files = {
          initial_mode = 'insert'
        },
        live_grep = {
          initial_mode = 'insert',
          additional_args = { '--pcre2' }
        },
        buffers = {
          initial_mode = 'insert',
          mappings = {
            n = { ['dd'] = telescope_delete_buffer },
            i = { ['<C-d>'] = telescope_delete_buffer }
          }
        }
      }
    }

    local map = require('config.globals').funcs.map
    local builtin = require('telescope.builtin')

    local builtin_buffers = function()
      builtin.buffers {
        ignore_current_buffer = true,
        sort_lastused = true
      }
    end

    map { mods = 'n', map = '<leader>b', cmd = builtin_buffers,
          opts = { silent = true, desc = 'Telescope: Buffers' } }

    map { mods = 'n', map = '<leader>sr', cmd = builtin.live_grep,
          opts = { silent = true, desc = 'Telescope: Search' } }

    map { mods = 'n', map = '<leader>se', cmd = builtin.find_files,
          opts = { silent = true, desc = 'Telescope: Files' } }
  end
}
