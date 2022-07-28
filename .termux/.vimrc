syntax enable
set scrolloff=3
set termguicolors
set listchars=space:⋅,tab:>\ ,eol:↴
" set nocompatible
" set guicursor=a:block

function! SetNumbersFunction()
	set list
	set cursorline
	set number
	set relativenumber
endfunction

function! UnsetNumbersFunction()
	set list &
	set cursorline &
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

function! TabsFunc2()
	set shiftwidth=2
	set tabstop=2
	set softtabstop=2
	set expandtab &
endfunction

function! SpaceFunc8()
	set shiftwidth=8
	set tabstop=8
	set softtabstop=8
	set expandtab
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

command Tab8 call TabsFunc8()
command Tab4 call TabsFunc4()
command Tab2 call TabsFunc2()
command Spac8 call SpaceFunc8()
command Spac4 call SpaceFunc4()
command Spac2 call SpaceFunc2()
command SetNumber call SetNumbersFunction()
command UnsetNumber call UnsetNumbersFunction()

call plug#begin()
	" Plug 'vim-airline/vim-airline'
	" Plug 'sainnhe/everforest'
	" Plug 'drewtempelmeyer/palenight.vim'
	" Plug 'sonph/onehalf', { 'rtp': 'vim' }
	" Plug 'dangerousScript/gruber-darker-nvim'
	Plug 'preservim/nerdtree'
	Plug 'itchyny/lightline.vim'
	Plug 'sainnhe/gruvbox-material'
call plug#end()

let NERDTreeShowHidden=1

set background=dark
colorscheme gruvbox-material
let g:gruvbox_material_background='soft'
let g:gruvbox_material_better_performance=1
" let g:everforest_background='medium'
" let g:everforest_better_performance=1

let g:lightline = {'colorscheme' : 'gruvbox_material'}
" let g:airline_powerline_fonts = 1
" let g:airline_theme = 'gruvbox_material'
" let g:airline_extensions = []

nmap <C-f> :NERDTreeToggle<CR>
nmap <C-j> :noh<CR>
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

autocmd VimEnter * SetNumber
autocmd BufEnter,Bufnew * Spac2
autocmd BufEnter,Bufnew *.py Spac4
autocmd BufEnter,Bufnew *.cpp Spac4
autocmd BufEnter,Bufnew *.cxx Spac4
autocmd BufEnter,Bufnew *.hpp Spac4
autocmd BufEnter,Bufnew *.hxx Spac4
autocmd BufEnter,Bufnew *.c Tab8
autocmd BufEnter,Bufnew *.h Tab8
autocmd BufEnter,Bufnew *.vim* Tab8
autocmd BufEnter,Bufnew Makefile Tab8
autocmd BufEnter,Bufnew .gitconfig Tab8
autocmd BufEnter,Bufnew .gitignore Tab8

autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
