set number
set relativenumber

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

function! TabsFunc8()
	set shiftwidth=8
	set tabstop=8
	set expandtab &
	echom "indent: 8xTab"
endfunction

function! TabsFunc4()
	set shiftwidth=4
	set tabstop=4
	set expandtab &
	echom "indent: 4xTab"
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
let g:airline_theme = 'base16_grayscale'
let g:airline_extensions = []

Spaces

au BufEnter,Bufnew *.html Mark
au BufEnter,Bufnew *.xml Mark
au BufEnter,Bufnew *.yml Mark
" au BufEnter,Bufnew *.c Tabs
" au BufEnter,Bufnew *.h Tabs
" au BufEnter,Bufnew *.cpp Tabs
au BufEnter,Bufnew *.vim Tabs
au BufEnter,Bufnew *.vimrc Tabs
au BufEnter,Bufnew .gitconfig Tabs
au BufEnter,Bufnew Makefile Tabs
