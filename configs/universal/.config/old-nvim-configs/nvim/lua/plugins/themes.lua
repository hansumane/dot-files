return {
  monokai = {
    'hansumane/monokai-pro.nvim',
    priority = 2000 - 1, lazy = false,
    config = function()
      require('monokai-pro').setup()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('monokai-pro')
    end
  },

  molokai = {
    'tomasr/molokai',
    priority = 2000 - 1, lazy = false,
    config = function()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('molokai')
      local highlights = {
        ["@lsp.type.comment"] = {},
        ["@lsp.type.comment.c"] = { link = "@comment" },
        ["@lsp.type.comment.cpp"] = { link = "@comment" },
          -- mini.indentscope
        MiniIndentscopeSymbol = { fg = "#465457" },
        -- indent-blankline (ibl) v3
        IblIndent = { fg = "#313b3d" },
        IblWhitespace = { fg = "#313b3d" },
        IblScope = { fg = "#465457" },
        -- indent-blankline v2
        IndentBlanklineChar = { fg = "#313b3d" },
        IndentBlanklineSpaceChar = { fg = "#313b3d" },
        IndentBlanklineSpaceCharBlankline = { fg = "#313b3d" },
        IndentBlanklineContextChar = { fg = "#465457" },
        IndentBlanklineContextSpaceChar = { fg = "#465457" },
      }
      for group, highlight in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, highlight)
      end
    end
  },

  rose_pine = {
    'rose-pine/neovim', name = 'rose-pine',
    priority = 2000 - 1, lazy = false,
    config = function()
      vim.opt.background = 'dark'
      require('rose-pine').setup {
        variant = 'auto',      -- auto, main, moon, dawn
        dark_variant = 'main', -- main, moon, dawn
        highlight_groups = {
          -- mini.indentscope
          MiniIndentscopeSymbol = { fg = 'highlight_med' },
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
    priority = 2000 - 1, lazy = false,
    config = function()
      vim.opt.background = 'dark'
      require('nordic').setup {
        on_highlight = function(highlights, palette)
          highlights.Todo = { fg = '#B48EAD' }
          -- mini.indentscope
          highlights.MiniIndentscopeSymbol = { fg = palette.gray2 }
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
  },

  everforest = {
    'sainnhe/everforest',
    priority = 2000 - 1, lazy = false,
    config = function()
      vim.opt.background = 'dark'
      vim.g.everforest_background = 'hard' -- hard, medium (default), soft
      vim.g.everforest_better_performance = 1
      vim.cmd.colorscheme('everforest')
    end
  },

  gruvbox_material = {
    'sainnhe/gruvbox-material',
    priority = 2000 - 1, lazy = false,
    config = function()
      vim.opt.background = 'dark'
      vim.g.gruvbox_material_foreground = 'original' -- material (default), mix, original
      vim.g.gruvbox_material_background = 'hard' -- hard, medium (default), soft
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd.colorscheme('gruvbox-material')
    end
  },

  gruber_darker = {
    'hansumane/gruber-darker.nvim',
    priority = 2000 - 1, lazy = false,
    config = function()
      require('gruber-darker').setup()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('gruber-darker')
    end
  },
}
