vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.mouse = 'nv'
vim.opt.scrolloff = 3
vim.opt.updatetime = 300
vim.cmd[[set iskeyword-=_]]
vim.opt.listchars = {
  tab = '⋅ >',
  trail = '␣'
}

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.termguicolors = true
vim.g.c_syntax_for_h = true

vim.opt.keymap = 'russian-jcukenwin'
vim.opt.iminsert = 0
vim.opt.imsearch = 0

vim.keymap.set('i', '<C-\\>', '<C-6>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('i', '<C-k>', '<C-v><C-i>')
vim.keymap.set('v', '<leader>k', '<cmd>sort<CR>')
vim.keymap.set('n', '<leader>j', '<cmd>nohlsearch<CR>')

function SetNumber(toggle)
  vim.opt.list = toggle and true or false
  vim.opt.number = toggle and true or false
  vim.opt.colorcolumn = toggle and {91, 140} or {}
  vim.opt.cursorline = toggle and true or false
  vim.opt.relativenumber = toggle and true or false
end

function SetIndent(settings)
  local shift = settings.spaces or 4
  local tabst = settings.tabs or 8
  local stabs = settings.tabs or 8
  local noexpand = settings.noexpand

  vim.opt.shiftwidth = shift
  vim.opt.tabstop = tabst
  vim.opt.softtabstop = stabs

  if noexpand then
    vim.opt.expandtab = false
  else
    vim.opt.expandtab = true
  end
end

vim.cmd [[
command SN :lua SetNumber(true)
command USN :lua SetNumber(false)
command S2 :lua SetIndent{spaces = 2}
command S4 :lua SetIndent{spaces = 4}
command S8 :lua SetIndent{spaces = 8}
command T2 :lua SetIndent{spaces = 2, tabs = 2, noexpand = true}
command T4 :lua SetIndent{spaces = 4, tabs = 4, noexpand = true}
command T8 :lua SetIndent{spaces = 8, tabs = 8, noexpand = true}
command M2 :lua SetIndent{spaces = 2, tabs = 4, noexpand = true}
command M4 :lua SetIndent{spaces = 4, tabs = 8, noexpand = true}
command MG :lua SetIndent{spaces = 2, tabs = 8, noexpand = true}
]]

SetNumber(true)
