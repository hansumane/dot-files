vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.mouse = 'nv'
vim.opt.scrolloff = 3
vim.opt.updatetime = 300
vim.opt.listchars = {
  tab = '⋅ >',
  trail = '␣'
}

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.termguicolors = true

vim.opt.keymap = 'russian-jcukenwin'
vim.opt.iminsert = 0
vim.opt.imsearch = 0

vim.keymap.set('i', '<C-\\>', '<C-6>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('i', '<C-k>', '<C-v><C-i>')
vim.keymap.set('v', '<leader>k', ':sort<CR>')
vim.keymap.set('n', '<leader>j', ':nohlsearch<CR>')

function setln(toggle)
  vim.opt.list = toggle and true or false
  vim.opt.number = toggle and true or false
  vim.opt.colorcolumn = toggle and '91,140' or ''
  vim.opt.cursorline = toggle and true or false
  vim.opt.relativenumber = toggle and true or false
end

function setind(n, mode)
  vim.opt.shiftwidth = n
  vim.opt.tabstop = n
  vim.opt.softtabstop = n

  if mode == 'tabs' then
    vim.opt.expandtab = false
  elseif mode == 'mixed' then
    vim.opt.tabstop = 2 * n
    vim.opt.expandtab = false
  else
    vim.opt.expandtab = true
  end
end

vim.cmd [[
command USN :lua setln()
command SN :lua setln(true)
command S2 :lua setind(2)
command S4 :lua setind(4)
command S8 :lua setind(8)
command T2 :lua setind(2, 'tabs')
command T4 :lua setind(4, 'tabs')
command T8 :lua setind(8, 'tabs')
command M2 :lua setind(2, 'mixed')
command M4 :lua setind(4, 'mixed')
]]

setln(true)
