local vars = require('config.globals').vars

return {
  enabled = vars.indentlines.ibl,
  'lukas-reineke/indent-blankline.nvim',
  lazy = false,
  config = function()
    require('ibl').setup(vars.ibl)
  end
}
