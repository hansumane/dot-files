local vscode = require('vscode')

-- Common:

vim.opt.cinoptions = '(0'
vim.opt.clipboard:append { 'unnamedplus' }

-- Keymaps:

for _, v in ipairs {
  { mods = 'n', map = 'gri' }, -- <= v0.11
  { mods = 'n', map = 'grn' }, -- <= v0.11
  { mods = 'n', map = 'grr' }, -- <= v0.11
  { mods = 'n', map = 'grt' }, -- <= v0.11
  { mods = 'n', map = 'grx' }, -- >= v0.12
  { mods = { 'n', 'x' }, map = 'gra' },
} do
  vim.keymap.del(v.mods, v.map)
end

vim.keymap.set('n', 'gr', function()
  vim.lsp.buf.references()
end, { desc = 'vim.lsp.buf.references()' })
