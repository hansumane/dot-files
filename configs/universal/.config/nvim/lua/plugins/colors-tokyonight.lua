return {
  enabled = false,
  'folke/tokyonight.nvim',
  lazy = false, priority = 1300,
  config = function()
    require('tokyonight').setup {
      on_highlights = function(highlights, colors)
        highlights['TodoBgTODO'] = { fg = colors.bg, bg = colors.purple, bold = true }
        highlights['TodoFgTODO'] = { fg = colors.purple }
        highlights['TodoSignTODO'] = { link = 'TodoFgTODO' }
      end
    }
    vim.o.background = require('config.globals').funcs.restore_bg(false)
    vim.cmd.colorscheme('tokyonight')
  end
}
