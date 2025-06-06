return {
  monokai = {
    'hansumane/monokai-pro.nvim',
    priority = 1000, lazy = false,
    config = function()
      require('monokai-pro').setup()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('monokai-pro')
    end
  },

  rose_pine = {
    'rose-pine/neovim', name = 'rose-pine',
    config = function()
      vim.opt.background = 'dark'
      require('rose-pine').setup {
        variant = 'auto',      -- auto, main, moon, dawn
        dark_variant = 'main', -- main, moon, dawn
        highlight_groups = {
          -- indent-blankline (ibl) v3
          IblIndent = { fg = 'overlay' },
          IblWhitespace = { fg = 'overlay' },
          IblScope = { fg = 'highlight_med' },
          -- indent-blankline v2
          IndentBlanklineChar = { fg = 'overlay' },
          IndentBlanklineSpaceChar = { fg = 'overlay' },
          IndentBlanklineSpaceCharBlankline = { fg = 'overlay' },
          IndentBlanklineContextChar = { fg = 'highlight_med' },
          IndentBlanklineContextSpaceChar = { fg = 'highlight_med' }
        }
      }
      vim.cmd.colorscheme('rose-pine')
    end
  },

  nordic = {
    'AlexvZyl/nordic.nvim',
    config = function()
      vim.opt.background = 'dark'
      require('nordic').setup {
        on_highlight = function(highlights, palette)
          highlights.Todo = { fg = '#B48EAD' }
          -- indent-blankline (ibl) v3
          highlights.IblIndent = { fg = palette.gray1 }
          highlights.IblWhitespace = { fg = palette.gray1 }
          highlights.IblScope = { fg = palette.gray2 }
          -- indent-blankline v2
          highlights.IndentBlanklineChar = { fg = palette.gray1 }
          highlights.IndentBlanklineSpaceChar = { fg = palette.gray1 }
          highlights.IndentBlanklineSpaceCharBlankline = { fg = palette.gray1 }
          highlights.IndentBlanklineContextChar = { fg = palette.gray2 }
          highlights.IndentBlanklineContextSpaceChar = { fg = palette.gray2 }
        end,
      }
      vim.cmd.colorscheme('nordic')
    end
  }
}
