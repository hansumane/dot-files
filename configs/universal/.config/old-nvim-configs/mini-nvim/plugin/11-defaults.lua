local vars = CreaGlobals.vars

vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

vim.g.mapleader = ' '

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

vim.g.c_syntax_for_h = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.fillchars = table.concat(
  { 'eob: ', 'fold:╌',
    'horiz:═', 'vert:║', 'verthoriz:╬',
    'vertleft:╣', 'horizdown:╦', 'horizup:╩', 'vertright:╠' },
  ','
)

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
