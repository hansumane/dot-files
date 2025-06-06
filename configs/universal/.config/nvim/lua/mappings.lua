local maps = {
  { mods = 'n', map = '<C-h>', cmd = '<C-w>h' },
  { mods = 'n', map = '<C-l>', cmd = '<C-w>l' },
  { mods = 'i', map = '<C-\\>', cmd = '<C-6>' },
  { mods = 'c', map = '<C-\\>', cmd = '<C-6>' },
  { mods = 't', map = '<Esc>', cmd = '<C-\\><C-n>' },
  { mods = 'i', map = '<C-r>', cmd = '<C-v><C-i>' },
  { mods = 'v', map = '<leader>k', cmd = ':sort<CR>' },
  { mods = 'n', map = '<leader>j', cmd = ':noh<CR>' },

  { mods = 'n', map = '<C-k>',
    cmd = require('defaults').funcs.switch_listchars },
  { mods = 'n', map = '<C-j>',
    cmd = function() require('defaults').funcs.update_cc('') end },
}

return {
  setup = function()
    vim.g.mapleader = ' '
    for _, v in ipairs(maps) do
      vim.keymap.set(v.mods, v.map, v.cmd, v.opts)
    end
  end,

  add = function(map)
    table.insert(maps, map)
  end,

  now = function(map)
    vim.keymap.set(map.mods, map.map, map.cmd, map.opts)
  end
}
