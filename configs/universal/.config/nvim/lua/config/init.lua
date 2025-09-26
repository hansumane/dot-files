local globals = require('config.globals')
local vars = globals.vars
local funcs = globals.funcs

local com = function(cmd, func) vim.api.nvim_create_user_command(cmd, func, {}) end

vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' ' -- '\\'

vim.o.list = true
vim.opt.listchars = vars.listchars.default

vim.o.wrap = false
vim.o.hidden = true
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.showmode = false

vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('state') .. '/undodir//'

vim.o.mouse = 'nv'
vim.o.scrolloff = 3
vim.o.laststatus = 2
vim.o.updatetime = 300
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 50

vim.o.showmatch = true
vim.o.matchtime = 1

vim.g.c_syntax_for_h = vars.c_syntax_for_h

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.o.fillchars = table.concat(
--   { 'eob: ', 'fold:╌',
--     'horiz:═', 'vert:║', 'verthoriz:╬',
--     'vertleft:╣', 'horizdown:╦', 'horizup:╩', 'vertright:╠' },
--   ','
-- )

vim.opt.viewoptions = { 'folds' }
vim.opt.clipboard:append { 'unnamedplus' }

-- default guicursor value, but with Cursor/lCursor highlights
vim.opt.guicursor = {
  'n-v-c-sm:block-Cursor/lCursor',
  'i-ci-ve:ver25-Cursor/lCursor',
  'r-cr-o:hor20-Cursor/lCursor',
  't:block-blinkon500-blinkoff500-TermCursor'
}

-- set cyrillic input method
vim.opt.langmap = {
  'ёЁ;`~', '№;#',
  'йЙ;qQ', 'цЦ;wW', 'уУ;eE', 'кК;rR', 'еЕ;tT', 'нН;yY', 'гГ;uU', 'шШ;iI', 'щЩ;oO', 'зЗ;pP', 'хХ;[{', 'ъЪ;]}',
  'фФ;aA', 'ыЫ;sS', 'вВ;dD', 'аА;fF', 'пП;gG', 'рР;hH', 'оО;jJ', 'лЛ;kK', 'дД;lL', [[жЖ;\;:]], [[эЭ;'\"]],
  'яЯ;zZ', 'чЧ;xX', 'сС;cC', 'мМ;vV', 'иИ;bB', 'тТ;nN', 'ьЬ;mM', [[бБ;\,<]], 'юЮ;.>',
}

com('SN',  function() funcs.set_number(true) end)
com('USN', function() funcs.set_number(false) end)
com('S2',  function() funcs.set_indent { spaces = 2 } end)
com('S4',  function() funcs.set_indent { spaces = 4 } end)
com('S8',  function() funcs.set_indent { spaces = 8 } end)
com('T2',  function() funcs.set_indent { spaces = 2, tabs = 2, noexpand = true } end)
com('T4',  function() funcs.set_indent { spaces = 4, tabs = 4, noexpand = true } end)
com('T8',  function() funcs.set_indent { spaces = 8, tabs = 8, noexpand = true } end)
com('M2',  function() funcs.set_indent { spaces = 2, tabs = 4, noexpand = true } end)
com('M4',  function() funcs.set_indent { spaces = 4, tabs = 8, noexpand = true } end)
com('MG',  function() funcs.set_indent { spaces = 2, tabs = 8, noexpand = true } end)

funcs.set_number(true)

require('editorconfig').properties.max_line_length = function(_, val)
  local n = tonumber(val)
  if n then
    funcs.update_cc(nil, n + 1)
  else
    assert(val == 'off', 'editorconfig: max_line_length: not number or "off"')
    funcs.update_cc(nil, vars.cd_init)
  end
end
