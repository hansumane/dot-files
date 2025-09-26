return {
  'echasnovski/mini.nvim',
  lazy = false, priority = 1000,
  config = function()
    local mini_statusline = require('mini.statusline')
    local mini_statusline_combine_groups = mini_statusline.combine_groups

    mini_statusline.setup()
    mini_statusline.combine_groups = function(groups)
      table.insert(groups, 6, {
        hl = 'MiniStatuslineFilename',
        strings = { require('config.globals').funcs.get_indent() }
      })
      --
      --  { hl = mode_hl,                  strings = { mode } },
      --  { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
      --  '%<', -- Mark general truncate point
      --  { hl = 'MiniStatuslineFilename', strings = { filename } },
      --  '%=', -- End left alignment
      --> { hl = 'MiniStatuslineFilename', strings = { funcs.get_indent() } },
      --  { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      --  { hl = mode_hl,                  strings = { search, location } },
      --
      return mini_statusline_combine_groups(groups)
    end

    require('config.globals').funcs.au {
      name = "User",
      data = {
        pattern = "VeryLazy",
        callback = function()
          local miniclue = require('mini.clue')

          miniclue.setup {
            window = { config = { border = 'double', width = 'auto' } },

            triggers = {
              { mode = 'n', keys = '<Leader>' },
              { mode = 'x', keys = '<Leader>' },

              { mode = 'n', keys = '<C-c>' },
              { mode = 'v', keys = '<C-c>' },

              { mode = 'n', keys = '<C-w>' },

              { mode = 'n', keys = 'g' },
              { mode = 'x', keys = 'g' },

              { mode = 'n', keys = 'z' },
              { mode = 'x', keys = 'z' }
            },

            clues = {
              {
                { mode = 'n', keys = '<Leader>s', desc = '+Search' },
                { mode = 'n', keys = '<Leader>g', desc = '+Gitsigns' },
                { mode = 'n', keys = '<Leader>l', desc = '+Lsp' }
              },

              miniclue.gen_clues.builtin_completion(),
              miniclue.gen_clues.g(),
              miniclue.gen_clues.marks(),
              miniclue.gen_clues.registers(),
              miniclue.gen_clues.windows(),
              miniclue.gen_clues.z()
            }
          }
        end
      }
    }
  end
}
