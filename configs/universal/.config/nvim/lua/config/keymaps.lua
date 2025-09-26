local funcs = require('config.globals').funcs

local maps = {
    --== common ==--
  { mods = 'x', map = '>', cmd = '>gv',
    opts = { silent = true, noremap = true } },

    --== common ==--
  { mods = 'x', map = '<', cmd = '<gv',
    opts = { silent = true, noremap = true } },

    --== weird ==--
  { mods = 'n', map = '*', cmd = '*N',
    opts = { silent = true, desc = '* and back' } },

    --== common ==--
  { mods = 'n', map = '<C-h>', cmd = '<C-w>h',
    opts = { desc = 'Go to Left Window' } },

    --== common ==--
  { mods = 'n', map = '<C-l>', cmd = '<C-w>l',
    opts = { desc = 'Go to Right Window' } },

    --== weird ==--
  { mods = 'i', map = '<C-r>', cmd = '<C-v><C-i>',
    opts = { desc = 'Insert <Tab>' } },

    --== specific ==--
  { mods = 'n', map = '[t', cmd = ':tabp<CR>',
    opts = { desc = 'Go to Previous Tab' } },

    --== specific ==--
  { mods = 'n', map = ']t', cmd = ':tabn<CR>',
    opts = { desc = 'Go to Previous Tab' } },

    --== specific ==--
  { mods = 'v', map = '<leader>k', cmd = ':sort<CR>',
    opts = { silent = true, desc = 'Sort Lines' } },

    --== specific ==--
  { mods = 'n', map = '<leader>j', cmd = ':nohlsearch<CR>',
    opts = { silent = true, desc = 'nohlsearch' } },

    --== common ==--
  { mods = 'n', map = '<C-t>', cmd = ':term<CR>',
    opts = { desc = 'Open term' } },

    --== specific ==--
  { mods = { 'n', 'v' }, map = '<C-k>', cmd = funcs.switch_listchars,
    opts = { desc = 'Switch listchars' } },

    --== specific ==--
  { mods = 'n', map = '<C-j>', cmd = function() funcs.update_cc('') end,
    opts = { desc = 'Switch colorcolumn' } },

    --== specific ==--
  { mods = { 'n', 'v' }, map = '<leader>t', cmd = function() funcs.restore_bg(true) end,
    opts = { desc = 'Switch and save dark or light background' } }
}

local unmaps = {
  { mods = 'n', map = 'gri' },
  { mods = 'n', map = 'grn' },
  { mods = 'n', map = 'grr' },
  { mods = 'n', map = 'grt' },
  { mods = { 'n', 'x' }, map = 'gra' },
}

for _, v in ipairs(maps) do
  vim.keymap.set(v.mods, v.map, v.cmd, v.opts)
end
for _, v in ipairs(unmaps) do
  vim.keymap.del(v.mods, v.map)
end

funcs.map = function(map)
  vim.keymap.set(map.mods, map.map, map.cmd, map.opts)
end
