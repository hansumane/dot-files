return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    local fzf_lua = require('fzf-lua')
    local map = require('config.globals').funcs.map

    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    local opts = {
      winopts = {
        fullscreen = true,
        preview = {
          layout = 'vertical',
          vertical = 'down:55%'
        },
        on_create = function()
          map { mods = 't', map = '<C-y>', cmd = [['<C-\><C-N>"+pi']],
                opts = { expr = true, noremap = true, buffer = true } }
        end
      },

      keymap = {
        builtin = {
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up'
        }
      },

      buffers = {
        keymap = {
          builtin = {
            ['<C-d>'] = false,
            ['<C-u>'] = false
          }
        },
        actions = {
          ['ctrl-x'] = false,
          ['ctrl-d'] = {
            reload = true,
            fn = function(sel)
              if sel then
                local bufnr = tonumber(sel[1]:match("%[(%d+)%]"))
                if bufnr > 0 then
                  Snacks.bufdelete { buf = bufnr }
                end
              end
            end
          }
        }
      }
    }

    fzf_lua.setup(opts)

    map { mods = 'n', map = '<leader>b', cmd = FzfLua.buffers,
          opts = { silent = true, desc = 'FzfLua: Buffers' } }

    map { mods = 'n', map = '<leader>sr', cmd = FzfLua.live_grep,
          opts = { silent = true, desc = 'FzfLua: Live grep' } }

    map { mods = 'n', map = '<leader>sR',
          cmd = function() FzfLua.live_grep { resume = true } end,
          opts = { silent = true, desc = 'FzfLua: Live grep' } }

    map { mods = 'n', map = '<leader>sf', cmd = FzfLua.files,
          opts = { silent = true, desc = 'FzfLua: Files' } }
  end
}
