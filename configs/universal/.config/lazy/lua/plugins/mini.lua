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
  end
}
