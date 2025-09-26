return {
  enabled = false,
  'catppuccin/nvim', name = 'catppuccin',
  lazy = false, priority = 1300,
  config = function()
    vim.env.FZF_DEFAULT_OPTS =
      '--color=bg+:#CCD0DA,bg:#E6E9EF,spinner:#DC8A78,hl:#D20F39 ' ..
      '--color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 ' ..
      '--color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 ' ..
      '--color=selected-bg:#BCC0CC ' ..
      '--color=border:#9CA0B0,label:#4C4F69 '

    require('catppuccin').setup {
      background = {
        dark = 'mocha',
        light = 'latte'
      },
      custom_highlights = function(colors)
        return {
          TodoBgTODO = { fg = colors.base, bg = colors.flamingo, bold = true },
          TodoFgTODO = { fg = colors.flamingo },
          TodoSignTODO = { link = 'TodoFgTODO' },
        }
      end
    }

    vim.o.background = require('config.globals').funcs.restore_bg(false)
    vim.cmd.colorscheme('catppuccin')
  end
}
