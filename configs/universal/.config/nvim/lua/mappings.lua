local funcs = require('defaults').funcs

local maps = {
  { mods = 'n', map = '<C-h>', cmd = '<C-w>h' },
  { mods = 'n', map = '<C-l>', cmd = '<C-w>l' },
  { mods = 'i', map = '<C-r>', cmd = '<C-v><C-i>' },
  { mods = 't', map = '<Esc>', cmd = '<C-\\><C-n>' },
  { mods = 'i', map = '<C-\\>', cmd = funcs.switch_input_language },
  { mods = 'c', map = '<C-\\>', cmd = funcs.switch_input_language },
  { mods = 'n', map = '<leader>c', cmd = funcs.buf_kill },
  { mods = 'v', map = '<leader>k', cmd = ':sort<CR>', opts = { silent = true } },

  { mods = 'n', map = '<C-j>', cmd = function() funcs.update_cc('') end },
  { mods = { 'n', 'v' }, map = '<C-k>', cmd = funcs.switch_listchars },
}

return {
  setup = function()
    vim.g.mapleader = ' '
    for _, v in ipairs(maps) do
      vim.keymap.set(v.mods, v.map, v.cmd, v.opts)
    end
  end,

  now = function(map)
    vim.keymap.set(map.mods, map.map, map.cmd, map.opts)
  end
}
