set termguicolors
syntax enable
set listchars=space:⋅,tab:>\ ,eol:↴


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
	Plug 'itchyny/lightline.vim' " Light status bar
	Plug 'preservim/nerdtree' " File browser
	Plug 'sainnhe/everforest' " Everforest Theme (soft green)
call plug#end()


set background=dark
let g:everforest_background='medium'
let g:everforest_better_performance=1
colorscheme everforest 

let g:lightline = {'colorscheme' : 'everforest'}

nmap <C-f> :NERDTreeToggle<CR>
nmap <C-h> :noh<CR>


autocmd VimEnter * SetNumber
autocmd BufEnter,Bufnew * Spaces
autocmd BufEnter,Bufnew *.m Mark
autocmd BufEnter,Bufnew *.html Mark
autocmd BufEnter,Bufnew *.xml Mark
autocmd BufEnter,Bufnew *.yml Mark
autocmd BufEnter,Bufnew *.sh* Mark
autocmd BufEnter,Bufnew *.zsh* Mark
autocmd BufEnter,Bufnew *.bash* Mark
" autocmd BufEnter,Bufnew *.c Tabs
" autocmd BufEnter,Bufnew *.h Tabs
" autocmd BufEnter,Bufnew *.cpp Tabs
autocmd BufEnter,Bufnew *.vim* Tabs
autocmd BufEnter,Bufnew .gitconfig Tabs
autocmd BufEnter,Bufnew Makefile Tabs

autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
