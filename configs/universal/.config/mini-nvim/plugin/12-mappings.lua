local funcs = CreaGlobals.funcs

local maps = {
    --== common ==--
  { mods = 'n', map = '<C-h>', cmd = '<C-w>h',
    opts = { desc = 'Go to Left Window' } },

    --== common ==--
  { mods = 'n', map = '<C-l>', cmd = '<C-w>l',
    opts = { desc = 'Go to Right Window' } },

    --== weird ==--
  { mods = 'i', map = '<C-r>', cmd = '<C-v><C-i>',
    opts = { desc = 'Insert <Tab>' } },

    --== breaking terminal ==--
  { mods = 't', map = '<Esc>', cmd = '<C-\\><C-n>',
    opts = { noremap = true, desc = 'Terminal Escape' } },

    --== specific ==--
  { mods = 'n', map = '[b', cmd = ':tabprevious<CR>',
    opts = { silent = true, desc = 'Previous Tab' } },

    --== specific ==--
  { mods = 'n', map = ']b', cmd = ':tabnext<CR>',
    opts = { silent = true, desc = 'Next Tab' } },

    --== specific ==--
  { mods = 'n', map = 'H', cmd = ':bprevious<CR>',
    opts = { silent = true, desc = 'Previous Tab' } },

    --== specific ==--
  { mods = 'n', map = 'L', cmd = ':bnext<CR>',
    opts = { silent = true, desc = 'Next Tab' } },

    --== specific ==--
  { mods = 'v', map = '<leader>k', cmd = ':sort<CR>',
    opts = { silent = true, desc = 'Sort Lines' } },

    --== specific ==--
  { mods = 'n', map = '<leader>j', cmd = ':nohlsearch<CR>',
    opts = { silent = true, desc = 'nohlsearch' } },

    --== unknown ==--
  { mods = 'n', map = '<leader>c', cmd = funcs.buf_kill,
    opts = { desc = 'Kill Buffer' } },

    --== specific ==--
  { mods = { 'n', 'v' }, map = '<C-k>', cmd = funcs.switch_listchars,
    opts = { desc = 'Switch listchars' } },

    --== specific ==--
  { mods = 'n', map = '<C-j>', cmd = function() funcs.update_cc('') end,
    opts = { desc = 'Switch colorcolumn' } },
}

local unmaps = {
  { mods = 'n', map = 'gri' },
  { mods = 'n', map = 'grn' },
  { mods = 'n', map = 'grr' },
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
