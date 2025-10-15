local funcs = require('defaults').funcs

local maps = {
  { mods = 'n', map = '<C-h>', cmd = '<C-w>h',
    opts = { desc = 'Go to Left Window' } },

  { mods = 'n', map = '<C-l>', cmd = '<C-w>l',
    opts = { desc = 'Goto Right Window' } },

  { mods = 'i', map = '<C-r>', cmd = '<C-v><C-i>',
    opts = { desc = 'Insert <Tab>' } },

  { mods = 't', map = '<Esc>', cmd = '<C-\\><C-n>',
    opts = { desc = 'Terminal Escape' } },

  { mods = 'i', map = '<C-\\>', cmd = funcs.switch_input_language,
    opts = { desc = 'Switch Language' } },

  { mods = 'c', map = '<C-\\>', cmd = funcs.switch_input_language,
    opts = { desc = 'Switch Language' } },

  { mods = 'n', map = '<leader>c', cmd = funcs.buf_kill,
    opts = { desc = 'Kill Buffer' } },

  { mods = 'v', map = '<leader>k', cmd = ':sort<CR>',
    opts = { silent = true, desc = 'Sort Lines' } },

  { mods = 'n', map = '<C-j>', cmd = function() funcs.update_cc('') end,
    opts = { desc = 'Switch colorcolumn' } },

  { mods = { 'n', 'v' }, map = '<C-k>', cmd = funcs.switch_listchars,
    opts = { desc = 'Switch listchars' } },
}

local unmaps = {
  { mods = 'n', map = 'gri' },
  { mods = 'n', map = 'grn' },
  { mods = 'n', map = 'grr' },
  { mods = { 'n', 'x' }, map = 'gra' },
}

return {
  setup = function()
    vim.g.mapleader = ' '
    for _, v in ipairs(maps) do
      vim.keymap.set(v.mods, v.map, v.cmd, v.opts)
    end
    for _, v in ipairs(unmaps) do
      vim.keymap.del(v.mods, v.map)
    end
  end,

  now = function(map)
    vim.keymap.set(map.mods, map.map, map.cmd, map.opts)
  end
}
