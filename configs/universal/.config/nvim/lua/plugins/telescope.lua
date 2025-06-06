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
        mappings = {
          n = { ['q'] = require('telescope.actions').close }
        },
        layout_config = {
          width = 0.95,
          height = 0.95,
          preview_width = 0.5
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

    map { mods = 'n', map = '<leader>b', opts = { silent = true },
          cmd = require('telescope.builtin').buffers }

    map { mods = 'n', map = '<leader>sf', opts = { silent = true },
          cmd = require('telescope.builtin').find_files }

    map { mods = 'n', map = '<leader>se', opts = { silent = true },
          cmd = require('telescope.builtin').live_grep }
  end
}
