return {
  monokai = {
    'hansumane/monokai-pro.nvim',
    config = function()
      require('monokai-pro').setup()
      vim.opt.background = 'dark'
      vim.cmd[[colorscheme monokai-pro]]
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
          IndentBlanklineChar = { fg = 'overlay' },
          IndentBlanklineSpaceChar = { fg = 'overlay' },
          IndentBlanklineSpaceCharBlankline = { fg = 'overlay' },
          IndentBlanklineContextChar = { fg = 'highlight_med' },
          IndentBlanklineContextSpaceChar = { fg = 'highlight_med' },
        }
      }
      vim.cmd[[colorscheme rose-pine]]
    end
  }
}
