return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      default_file_explorer = true,
      view_options = { show_hidden = true },
      keymaps = { ['<C-t>'] = false }
    }

    local map = require('config.globals').funcs.map

    map { mods = 'n', map = '<leader>e', cmd = ':Oil .<CR>',
          opts = { silent = true, noremap = true, desc = 'Oil: CWD' } }

    map { mods = 'n', map = '<leader>.', cmd = ':Oil<CR>',
          opts = { silent = true, noremap = true, desc = 'Oil: Parent Dir' } }
  end
}
