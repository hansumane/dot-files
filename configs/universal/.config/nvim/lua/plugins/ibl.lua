local vars = {
  enabled = true,
  indent = { char = '┊', tab_char = '┊' }, -- '▏', '┊'
  scope = { enabled = false }
}

return {
  plugin = {
    'lukas-reineke/indent-blankline.nvim', main = 'ibl',
    opts = vars
  },
  get_vars = function()
    return vars
  end,
  setup = function()
    require('ibl').setup(vars)
  end
}
