syntax enable
set mouse=nv
set scrolloff=3
set updatetime=300
set listchars=tab:⋅\ >,trail:␣

set nobackup
set termguicolors
set nowritebackup

function! SetNumbersFunction()
	set list
	set number
	set cursorline
	set colorcolumn=101
	set relativenumber
endfunction

function! UnsetNumbersFunction()
	set list &
	set number &
	set cursorline &
	set colorcolumn &
	set relativenumber &
endfunction

function! TabsFunc8()
	set shiftwidth=8
	set tabstop=8
	set softtabstop=8
	set noexpandtab
endfunction

function! TabsFunc4()
	set shiftwidth=4
	set tabstop=4
	set softtabstop=4
	set noexpandtab
endfunction

function! MixIndent4()
	set shiftwidth=4
	set tabstop=8
	set softtabstop=4
	set noexpandtab
endfunction

function! SpaceFunc4()
	set shiftwidth=4
	set tabstop=8
	set softtabstop=4
	set expandtab
endfunction

function! SpaceFunc2()
	set shiftwidth=2
	set tabstop=8
	set softtabstop=2
	set expandtab
endfunction

command Tab8 call TabsFunc8()
command Tab4 call TabsFunc4()
command Mix4 call MixIndent4()
command Spac4 call SpaceFunc4()
command Spac2 call SpaceFunc2()
command SetNumber call SetNumbersFunction()
command UnsetNumber call UnsetNumbersFunction()

call plug#begin()
	Plug 'preservim/nerdtree'
	Plug 'itchyny/lightline.vim'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()

set background=dark
colorscheme catppuccin-macchiato

let g:lightline = { 'colorscheme' : 'catppuccin' }
let NERDTreeShowHidden=1
let g:coc_snippet_next = '<tab>'
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
imap <C-k> <C-v><C-i>
nmap <C-j> :nohlsearch<CR>
nmap <C-f> :NERDTreeToggle<CR>
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ?
	\ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ CheckBackSpace() ? "\<TAB>" :
	\ coc#refresh()
function! CheckBackSpace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd VimEnter * SetNumber
autocmd BufEnter,Bufnew * Spac4
autocmd BufEnter,Bufnew *.c Spac2
autocmd BufEnter,Bufnew *.h Spac2
autocmd BufEnter,Bufnew *.sh* Spac2
autocmd BufEnter,Bufnew *.zsh* Spac2
autocmd BufEnter,Bufnew *.bash* Spac2
autocmd BufEnter,Bufnew *.s Tab8
autocmd BufEnter,Bufnew *.asm Tab8
autocmd BufEnter,Bufnew *.vim* Tab8
autocmd BufEnter,Bufnew Makefile Tab8
autocmd BufEnter,Bufnew .gitconfig Tab8
autocmd BufEnter,Bufnew .gitignore Tab8
