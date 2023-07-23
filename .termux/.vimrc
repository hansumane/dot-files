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
	set colorcolumn=91
	set relativenumber
endfunction

function! UnsetNumbersFunction()
	set list &
	set number &
	set cursorline &
	set colorcolumn &
	set relativenumber &
endfunction

function! SetIndent(n, mode)
	let &shiftwidth = a:n
	let &tabstop = a:n
	let &softtabstop = a:n

	if a:mode=="tabs"
		set noexpandtab
	elseif a:mode=="mixed"
		let &tabstop=2 * a:n
		set noexpandtab
	else
		set expandtab
	endif
endfunction

command Spac2 call SetIndent(2, "")
command Spac4 call SetIndent(4, "")
command Tab4 call SetIndent(4, "tabs")
command Tab8 call SetIndent(8, "tabs")
command Mix4 call SetIndent(4, "mixed")
command SetNumber call SetNumbersFunction()
command UnsetNumber call UnsetNumbersFunction()

call plug#begin()
	Plug 'preservim/nerdtree'
	Plug 'itchyny/lightline.vim'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	Plug 'nathanalderson/yang.vim'
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
autocmd BufEnter,Bufnew *.xml,*.html,*.yang*,*.sh*,*.zsh*,*.bash* Spac2
autocmd BufEnter,Bufnew *.s,*.c,*.h,*.vim*,Makefile,*.git* Tab8
