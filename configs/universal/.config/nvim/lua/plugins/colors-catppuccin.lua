return {
  enabled = true,
  'catppuccin/nvim', name = 'catppuccin',
  commit = '05e8787020dcfdb937bf2ff23855ea2415b4e072',
  lazy = false, priority = 1300,
  config = function()
    require('catppuccin').setup {
      background = {
        light = 'latte',
        dark = 'mocha'
      },
      custom_highlights = function(colors)
        return {
          TodoBgNOTE   = { fg   = colors.base, bg = colors.blue, bold = true },
          TodoFgNOTE   = { fg   = colors.blue                                },
          TodoSignNOTE = { link = 'TodoFgNOTE'                               },

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
    vim.cmd.colorscheme('catppuccin-nvim')
  end
}
