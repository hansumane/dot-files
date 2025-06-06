local vars = require('defaults').funcs.get_vars()
local ibl_vars = require('plugins.ibl').get_vars()

return {
  'echasnovski/mini.nvim', version = false,
  config = function()
    if vars.enable_indentlines then
      require('mini.indentscope').setup {
        symbol = ibl_vars.indent.char,
        mappings = {
          -- Textobjects
          object_scope = '', -- 'ii'
          object_scope_with_border = '', -- 'ai'
          -- Motions (jump to respective border line; if not present - body line)
          goto_top = '', -- '[i'
          goto_bottom = '', -- ']i'
        },
        options = {
          -- 'both' | 'top' | 'bottom' | 'none'
          border = 'top'
        }
      }
    end
  end
}
