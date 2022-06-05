" this is still neovim configuration in vim script
" but I wish I remake it with lua, as some plugins
" do not work with vimscript, but perfectly work
" with lua!

set termguicolors
" set nocompatible " nvim is always nocompatible
syntax enable

set list
set listchars=space:⋅,tab:>\ ,eol:↴

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

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
	set softtabstop=8
	set expandtab &
endfunction

function! TabsFunc4()
	set shiftwidth=4
	set tabstop=4
	set softtabstop=4
	set expandtab &
endfunction

function! SpaceFunc4()
	set shiftwidth=4
	set tabstop=4
	set softtabstop=4
	set expandtab
endfunction

function! SpaceFunc2()
	set shiftwidth=2
	set tabstop=2
	set softtabstop=2
	set expandtab
endfunction

command Tabs call TabsFunc8()
command Tabx call TabsFunc4()
command Spaces call SpaceFunc4()
command Mark call SpaceFunc2()
command SetNumber call SetNumbersFunction()
command UnsetNumber call UnsetNumbersFunction()

call plug#begin()
	Plug 'sainnhe/everforest' " Theme
	Plug 'vim-airline/vim-airline' " Status bar
	Plug 'vim-airline/vim-airline-themes' " Status bar themes
	Plug 'preservim/nerdtree' " File browser
call plug#end()

set background=dark
let g:everforest_background='medium'
let g:everforest_better_performance=1
colorscheme everforest

let g:airline_powerline_fonts = 1
" let g:airline_theme = 'base16_grayscale'
let g:airline_theme = 'everforest'
let g:airline_extensions = []

nmap <C-f> :NERDTreeToggle<CR>
nmap <C-h> :noh<CR>

au VimEnter * SetNumber
au VimEnter * NERDTree
au VimEnter * NERDTreeToggle<CR>

au BufEnter,Bufnew * Spaces
au BufEnter,Bufnew *.m Mark
au BufEnter,Bufnew *.html Mark
au BufEnter,Bufnew *.xml Mark
au BufEnter,Bufnew *.yml Mark
au BufEnter,Bufnew *.sh* Mark
au BufEnter,Bufnew *.zsh* Mark
au BufEnter,Bufnew *.bash* Mark
" au BufEnter,Bufnew *.c Tabs
" au BufEnter,Bufnew *.h Tabs
" au BufEnter,Bufnew *.cpp Tabs
au BufEnter,Bufnew *.vim Tabs
au BufEnter,Bufnew *.vimrc Tabs
au BufEnter,Bufnew .gitconfig Tabs
au BufEnter,Bufnew Makefile Tabs

au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
