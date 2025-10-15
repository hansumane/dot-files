local telescope_delete_buffer = function(prompt_bufnr)
  local buf_kill = require('defaults').funcs.buf_kill
  local action_state = require 'telescope.actions.state'
  local current_picker = action_state.get_current_picker(prompt_bufnr)

  current_picker:delete_selection(function(selection)
    local ok = pcall(buf_kill, selection.bufnr)
    return ok
  end)
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        initial_mode = 'normal',
        sorting_strategy = "ascending",
        mappings = {
          -- <C-q> to open search results in a quickfix
          n = { ['q'] = require('telescope.actions').close }
        },
        layout_config = {
          preview_width = 0.6,
          width = { padding = 0 }, -- width = 1.0, -- doesn't work
          height = { padding = 0 }, -- height = 1.0, -- doesn't work
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
          initial_mode = 'normal',
          mappings = {
            n = { ['dd'] = telescope_delete_buffer }
          }
        }
      }
    }

    local map = require('mappings').now
    local builtin = require('telescope.builtin')

    map { mods = 'n', map = '<leader>b', cmd = builtin.buffers,
          opts = { silent = true, desc = 'Telescope: Buffers' } }

    map { mods = 'n', map = '<leader>se', cmd = builtin.live_grep,
          opts = { silent = true, desc = 'Telescope: Search' } }

    map { mods = 'n', map = '<leader>sf', cmd = builtin.find_files,
          opts = { silent = true, desc = 'Telescope: Files' } }
  end
}
