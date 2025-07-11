local vars = CreaGlobals.vars
local funcs = CreaGlobals.funcs

vim.g.mapleader = ' '

vim.opt.list = true
vim.opt.listchars = vars.listchars.default

vim.opt.wrap = false
vim.opt.hidden = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.showmode = false

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('state') .. '/undodir'

vim.opt.mouse = 'nv'
vim.opt.scrolloff = 3
vim.opt.laststatus = 2
vim.opt.updatetime = 300
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 50

vim.opt.showmatch = true
vim.opt.matchtime = 1

vim.g.c_syntax_for_h = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.clipboard:append { 'unnamedplus' }

-- default guicursor value, but with Cursor/lCursor highlights
vim.opt.guicursor = 'n-v-c-sm:block-Cursor/lCursor,' ..
                    'i-ci-ve:ver25-Cursor/lCursor,' ..
                    'r-cr-o:hor20-Cursor/lCursor,' ..
                    't:block-blinkon500-blinkoff500-TermCursor'

-- set russian input method
vim.opt.langmap = {
  'ёЁ;`~', '№;#',
  'йЙ;qQ', 'цЦ;wW', 'уУ;eE', 'кК;rR', 'еЕ;tT', 'нН;yY', 'гГ;uU', 'шШ;iI', 'щЩ;oO', 'зЗ;pP', 'хХ;[{', 'ъЪ;]}',
  'фФ;aA', 'ыЫ;sS', 'вВ;dD', 'аА;fF', 'пП;gG', 'рР;hH', 'оО;jJ', 'лЛ;kK', 'дД;lL', [[жЖ;\;:]], [[эЭ;'\"]],
  'яЯ;zZ', 'чЧ;xX', 'сС;cC', 'мМ;vV', 'иИ;bB', 'тТ;nN', 'ьЬ;mM', [[бБ;\,<]], 'юЮ;.>',
}
