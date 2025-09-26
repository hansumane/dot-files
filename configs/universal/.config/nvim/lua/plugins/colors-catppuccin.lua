return {
  enabled = true,
  'catppuccin/nvim', name = 'catppuccin',
  lazy = false, priority = 1300,
  config = function()
    require('catppuccin').setup {
      background = {
        dark = 'mocha',
        light = 'latte'
      },
      custom_highlights = function(colors)
        return {
          TodoBgNOTE   = { fg   = colors.bse, bg = colors.blue, bold = true },
          TodoFgNOTE   = { fg   = colors.blue                               },
          TodoSignNOTE = { link = 'TodoFgNOTE'                              },

          TodoBgPERF   = { link = 'TodoBgNOTE'   },
          TodoFgPERF   = { link = 'TodoFgNOTE'   },
          TodoSignPERF = { link = 'TodoSignNOTE' },

          TodoBgTODO   = { fg   = colors.base, bg = colors.flamingo, bold = true },
          TodoFgTODO   = { fg   = colors.flamingo                                },
          TodoSignTODO = { link = 'TodoFgTODO'                                   },
        }
      end
    }

    vim.o.background = require('config.globals').funcs.restore_bg(false)
    vim.cmd.colorscheme('catppuccin')
  end
}
