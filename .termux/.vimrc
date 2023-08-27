syntax enable

set mouse=nv
set scrolloff=3
set updatetime=300
set listchars=tab:⋅\ >,trail:␣

set nobackup
set termguicolors
set nowritebackup

"" dependencies: nodejs / npm / yarn & pynvim / pylint / jedi
call plug#begin()
	"" Plug 'vim-airline/vim-airline'
	"" Plug 'nathanalderson/yang.vim'
	"" Plug 'morhetz/gruvbox'
	"" Plug 'sainnhe/everforest'
	"" Plug 'jacoborus/tender.vim'
	"" Plug 'shaunsingh/nord.nvim'
	"" Plug 'sainnhe/gruvbox-material'
	"" Plug 'drewtempelmeyer/palenight.vim'
	"" Plug 'sonph/onehalf', { 'rtp': 'vim' }
	Plug 'preservim/nerdtree'
	Plug 'itchyny/lightline.vim'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()

set background=dark
colorscheme catppuccin-macchiato
"" let g:everforest_background='medium'
"" let g:gruvbox_material_background='soft'

let g:lightline = {
\	'colorscheme': 'catppuccin',
\	'active': {
\		'left': [ [ 'mode', 'paste' ],
\			  [ 'readonly', 'filename', 'modified' ] ],
\		'right': [ [ 'lineinfo' ],
\			   [ 'percent' ],
\			   [ 'fileformat', 'fileencoding', 'indentv', 'filetype' ] ]
\	},
\	'component_function': {
\		'indentv': 'GetIndent'
\	}
\}
"" let g:airline_powerline_fonts = 1
"" let g:airline_theme = 'catppuccin'
"" let g:airline_extensions = []

let NERDTreeShowHidden=1
let g:coc_snippet_next='<tab>'
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

function! GetIndent()
	let result = &shiftwidth . "/" . &tabstop . "-"
	if &expandtab
		let result .= "S"
	elseif (&shiftwidth != &tabstop)
		let result .= "M"
	else
		let result .= "T"
	endif
	return result
endfunction

command S2 call SetIndent(2, "")
command S4 call SetIndent(4, "")
command T4 call SetIndent(4, "tabs")
command T8 call SetIndent(8, "tabs")
command M2 call SetIndent(2, "mixed")
command M4 call SetIndent(4, "mixed")
command SN call SetNumbersFunction()
command USN call UnsetNumbersFunction()

autocmd VimEnter * SN
autocmd BufEnter,Bufnew * S4
autocmd BufEnter,Bufnew *.xml,*.html,*.yang*,*.sh*,*.zsh*,*.bash* S2
autocmd BufEnter,Bufnew *.s,*.c,*.h,*.vim*,Makefile,*.git* T8
autocmd BufEnter,Bufnew *.lua,*tac_plus.cfg T4
