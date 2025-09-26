return {
  'folke/snacks.nvim',
  lazy = false, priority = 1200,
  config = function()
    require('snacks').setup {
      bufdelete = { enabled = true },
      lazygit = { enabled = true }
    }

    local map = require('config.globals').funcs.map

    map { mods = 'n', map = '<leader>c', cmd = function() Snacks.bufdelete() end,
          opts = { desc = 'Snacks: BufDelete' } }

    map { mods = 'n', map = '<leader>gg', cmd = function() Snacks.lazygit() end,
          opts = { desc = 'Snacks: LazyGit' } }
  end
}
