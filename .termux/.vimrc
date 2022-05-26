set nocompatible
syntax enable

function! SetNumbersFunction()
	set number
	set relativenumber
endfunction

function! UnsetNumbersFunction()
	set number &
	set relativenumber &
endfunction

function! TabsFunc8()
	set shiftwidth=8
	set tabstop=8
	set expandtab &
endfunction

function! TabsFunc4()
	set shiftwidth=4
	set tabstop=4
	set expandtab &
endfunction

function! SpaceFunc4()
	set shiftwidth=4
	set tabstop=4
	set expandtab
endfunction

function! SpaceFunc2()
	set shiftwidth=2
	set tabstop=2
	set expandtab
endfunction

command Tabs call TabsFunc8()
command Tabx call TabsFunc4()
command Spaces call SpaceFunc4()
command Mark call SpaceFunc2()
command SetNumber call SetNumbersFunction()
command UnsetNumber call UnsetNumbersFunction()

call plug#begin()
	Plug 'vim-airline/vim-airline' " Status bar
	Plug 'vim-airline/vim-airline-themes' " Status bar themes
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_grayscale'
let g:airline_extensions = []

autocmd VimEnter * SetNumber

autocmd BufEnter,Bufnew * Spaces
autocmd BufEnter,Bufnew *.html Mark
autocmd BufEnter,Bufnew *.xml Mark
autocmd BufEnter,Bufnew *.yml Mark
autocmd BufEnter,Bufnew *.sh* Mark
autocmd BufEnter,Bufnew *.zsh* Mark
autocmd BufEnter,Bufnew *.bash* Mark
autocmd BufEnter,Bufnew *.vim* Tabs
autocmd BufEnter,Bufnew *.git* Tabs
autocmd BufEnter,Bufnew Makefile Tabs
