return {
  'folke/tokyonight.nvim',
  lazy = false, priority = 1300,
  config = function()
    ---@class tokyonight.Config
    ---@field on_colors fun(colors: ColorScheme)
    ---@field on_highlights fun(highlights: tokyonight.Highlights, colors: ColorScheme)
    local opts = {
      on_highlights = function(highlights, colors)
        highlights['TodoBgTODO'] = { fg = colors.bg, bg = colors.purple, bold = true }
        highlights['TodoFgTODO'] = { fg = colors.purple }
        highlights['TodoSignTODO'] = { link = 'TodoFgTODO' }
      end
    }

    require('tokyonight').setup(opts)
    vim.cmd.colorscheme('tokyonight')
  end
}
