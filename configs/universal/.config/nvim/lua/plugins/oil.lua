return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    ---@module 'oil'
    ---@type oil.SetupOpts
    local opts = {
      default_file_explorer = true,
      view_options = { show_hidden = true },
      keymaps = { ['<C-t>'] = false }
    }
    require('oil').setup(opts)

    local funcs = require('config.globals').funcs
    local map = funcs.map

    map { mods = 'n', map = '<leader>e', cmd = ':Oil .<CR>',
          opts = { silent = true, noremap = true, desc = 'Oil: CWD' } }

    map { mods = 'n', map = '<leader>f', cmd = ':Oil<CR>',
          opts = { silent = true, noremap = true, desc = 'Oil: Parent Dir' } }
  end
}
