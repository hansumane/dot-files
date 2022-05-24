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
" if !exists('g:airline_symbols')
" 	let g:airline_symbols = {}
" endif

au VimEnter * SetNumber

au BufEnter,Bufnew * Spaces
au BufEnter,Bufnew *.html Mark
au BufEnter,Bufnew *.xml Mark
au BufEnter,Bufnew *.yml Mark
au BufEnter,Bufnew *.vim Tabs
au BufEnter,Bufnew *.vimrc Tabs
au BufEnter,Bufnew .gitconfig Tabs
au BufEnter,Bufnew Makefile Tabs
