syntax enable
set termguicolors
set guicursor=a:block
set listchars=tab:>\ 
" set listchars=space:⋅,tab:>\ ,eol:↴

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

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
	" Plug 'vim-airline/vim-airline'
	" Plug 'sainnhe/everforest'
	" Plug 'sonph/onehalf', { 'rtp': 'vim' }
	" Plug 'drewtempelmeyer/palenight.vim'
	" Plug 'itchyny/lightline.vim'
	Plug 'preservim/nerdtree'
	Plug 'drsooch/gruber-darker-vim'
call plug#end()

" set background=dark
" let g:everforest_background='medium'
" let g:everforest_better_performance=1
colorscheme GruberDarker

" let g:lightline = {'colorscheme' : 'palenight'}
" let g:airline_powerline_fonts = 1
" let g:airline_theme = 'everforest'
" let g:airline_extensions = []

nmap <C-f> :NERDTreeToggle<CR>
nmap <C-h> :noh<CR>

autocmd VimEnter * SetNumber
" autocmd VimEnter * NERDTree
" autocmd VimEnter * NERDTreeToggle<CR>

autocmd BufEnter,Bufnew * Spaces
autocmd BufEnter,Bufnew *.m Mark
autocmd BufEnter,Bufnew *.html Mark
autocmd BufEnter,Bufnew *.xml Mark
autocmd BufEnter,Bufnew *.yml Mark
autocmd BufEnter,Bufnew *.sh* Mark
autocmd BufEnter,Bufnew *.zsh* Mark
autocmd BufEnter,Bufnew *.bash* Mark
autocmd BufEnter,Bufnew *.c Tabs
autocmd BufEnter,Bufnew *.h Tabs
" autocmd BufEnter,Bufnew *.cpp Tabs
" autocmd BufEnter,Bufnew *.hpp Tabs
autocmd BufEnter,Bufnew *.vim* Tabs
autocmd BufEnter,Bufnew .gitconfig Tabs
autocmd BufEnter,Bufnew .gitignore Tabs
autocmd BufEnter,Bufnew Makefile Tabs

autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
