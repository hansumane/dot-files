return {
  'lambdalisue/vim-suda',
  lazy = false,
  init = function()
    -- vim.g['suda_smart_edit'] = 1
    vim.g['suda#noninteractive'] = 1
  end,
  config = function()
    local map = require('config.globals').funcs.map

    map { mods = 'n', map = '<leader>S', cmd = ':SudaRead<CR>',
          opts = { silent = true, desc = 'Suda Read' } }
  end
}
