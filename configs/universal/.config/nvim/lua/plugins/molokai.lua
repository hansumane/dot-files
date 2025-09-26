return {
  'tomasr/molokai',
  lazy = false, priority = 1300,
  config = function()
    vim.opt.background = 'dark'
    vim.cmd.colorscheme('molokai')

    local highlights = {
      -- mini.indentscope
      MiniIndentscopeSymbol = { fg = '#465457' },
      -- mini.statusline
      MiniStatuslineModeNormal = { fg = '#F8F8F2', bg = '#293739' },
      MiniStatuslineModeInsert = { link = 'MiniStatuslineModeNormal' },
      MiniStatuslineModeVisual = { fg = '#F8F8F2', bg = '#3E3D32' },
      MiniStatuslineModeReplace = { link = 'MiniStatuslineModeNormal' },
      MiniStatuslineModeCommand = { link = 'MiniStatuslineModeNormal' },
      MiniStatuslineModeOther = { link = 'MiniStatuslineModeNormal' },
      MiniStatuslineDevinfo = { link = 'LineNr' },
      MiniStatuslineFilename = { link = 'LineNr' },
      MiniStatuslineFileinfo = { link = 'LineNr' },
      MiniStatuslineInactive = { link = 'LineNr' },
      -- indent-blankline (ibl) v3
      IblIndent = { fg = '#313b3d' },
      IblWhitespace = { fg = '#313b3d' },
      IblScope = { fg = '#465457' },
      -- indent-blankline v2
      IndentBlanklineChar = { fg = '#313b3d' },
      IndentBlanklineSpaceChar = { fg = '#313b3d' },
      IndentBlanklineSpaceCharBlankline = { fg = '#313b3d' },
      IndentBlanklineContextChar = { fg = '#465457' },
      IndentBlanklineContextSpaceChar = { fg = '#465457' },
      -- tree-sitter
      ['@markup.raw.block.markdown'] = { link ='@nospell' }
    }

    for group, highlight in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, highlight)
    end
  end
}
