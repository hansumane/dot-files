return {
  "brenton-leighton/multiple-cursors.nvim", version = "*",
  event = 'VeryLazy',
  config = function()
    require('multiple-cursors').setup{}

    local map = require('config.globals').funcs.map

    map { mods = { 'n', 'x' }, map = '<C-h>',
          cmd = ':MultipleCursorsAddDown<CR>',
          opts = { silent = true, noremap = true,
                   desc = 'MultipleCursors: Add cursor and move down' } }

    map { mods = { 'n', 'x' }, map = '<C-l>',
          cmd = ':MultipleCursorsAddUp<CR>',
          opts = { silent = true, noremap = true,
                   desc = 'MultipleCursors: Add cursor and move up' } }
  end
}
