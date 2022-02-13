set number
set relativenumber

function! TabsFunc8()
	set shiftwidth=8
	set tabstop=8
	set expandtab &
	echom "indent: Tab"
endfunction

function! TabsFunc4()
	set shiftwidth=4
	set tabstop=4
	set expandtab &
	echom "indent: Tab"
endfunction

function! SpaceFunc4()
	set shiftwidth=4
	set tabstop=4
	set expandtab
	echom "indent: 4xSpace"
endfunction

function! SpaceFunc2()
	set shiftwidth=2
	set tabstop=2
	set expandtab
	echom "indent: 2xSpace"
endfunction

command Tabs call TabsFunc8()
command Tabx call TabsFunc4()
command Spaces call SpaceFunc4()
command Mark call SpaceFunc2()

call plug#begin()
Plug 'vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes' " Status bar themes
call plug#end()

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_theme = 'base16'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let b:airline_whitespace_checks = []

Spaces

au BufEnter,Bufnew *.html Mark
au BufEnter,Bufnew *.xml Mark
au BufEnter,Bufnew *.yml Mark
#au BufEnter,Bufnew *.c Tabs
#au BufEnter,Bufnew *.h Tabs
#au BufEnter,Bufnew *.cpp Tabs
au BufEnter,Bufnew *.vim Tabs
au BufEnter,Bufnew .gitconfig Tabs
au BufEnter,Bufnew Makefile Tabs
