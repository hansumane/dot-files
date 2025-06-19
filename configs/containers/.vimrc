" call plug#begin()
" 	" - themes -
" 	Plug 'tomasr/molokai'
" 	" - functional -
" 	Plug 'cohama/lexima.vim'
" 	Plug 'preservim/nerdtree'
" 	Plug 'airblade/vim-rooter'
" 	Plug 'ctrlpvim/ctrlp.vim'
" 	Plug 'tpope/vim-fugitive'
" 	Plug 'airblade/vim-gitgutter'
" 	Plug 'vim-scripts/autoload_cscope.vim'
" 	" - code -
" 	Plug 'hansumane/c.vim'
" 	Plug 'vim-syntastic/syntastic'
" 	Plug 'editorconfig/editorconfig-vim'
" 	" - LSP -
" 	" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" 	" = alternative =
" 	" - functional -
" 	" Plug 'vifm/vifm.vim'
" 	" - LSP -
" 	Plug 'prabirshrestha/vim-lsp'
" 	Plug 'mattn/vim-lsp-settings'
" 	Plug 'prabirshrestha/asyncomplete.vim'
" 	Plug 'prabirshrestha/asyncomplete-lsp.vim'
" call plug#end()

set list
set hidden
set termguicolors

set hlsearch
set incsearch
set showmatch
set ignorecase
set smartcase

set nobackup
set nowritebackup
set noswapfile
set noshowmode

set undofile
set undodir=~/.vim/undodir

set mouse=nv
set scrolloff=3
set laststatus=2
set updatetime=300
set timeoutlen=1000
set ttimeoutlen=50

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

set signcolumn=yes
set background=dark

colorscheme molokai

if has('nvim')
	set clipboard+=unnamedplus
elseif has('clipboard')
	nnoremap dd "+dd
	vnoremap d "+d
	nnoremap D "+D

	nnoremap p "+p
	vnoremap p "+p

	nnoremap y "+y
	vnoremap y "+y

	nnoremap P "+P
	vnoremap P "+P

	nnoremap Y "+Y
	vnoremap Y "+Y
endif

let g:c_style = '' " 'GNU'
let g:c_syntax_for_h = 1

let g:vifm_embed_term = 1
let g:vifm_embed_split = 1
let g:vifm_exec_args = '-c :only'

let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

let g:rooter_patterns = ['.git', '.vi_project_root']
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1

let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_align = 'right'
let g:lsp_settings_enable_suggestions = 0

let g:syntastic_c_checkpatch_exec = '/usr/local/bin/checkpatch.pl'
let g:syntastic_c_checkpatch_args = join([
	\ '--no-tree', '--no-signoff', '--show-types', '--strict',
	\ '--max-line-length=90', '--ignore',
	\ 'SPDX_LICENSE_TAG,PREFER_KERNEL_TYPES',
	\ ])

cnoremap <C-\> <C-6>
inoremap <C-\> <C-6>
inoremap <C-r> <C-v><C-i>
tnoremap <Esc> <C-\><C-n>

let mapleader = ' '

nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>l :CocList<CR>
nnoremap <silent> <leader>j :noh<CR>
nnoremap <silent> <leader>c :bd<CR>
vnoremap <leader>k :sort<CR>

nnoremap <leader>gj <Plug>(GitGutterNextHunk)
nnoremap <leader>gk <Plug>(GitGutterPrevHunk)

function SplitVifm()
	let l:width = float2nr(&columns / 3)
	execute 'leftabove vertical ' . l:width . ' Vifm'
endfunction
nnoremap <silent><expr> <leader>e exists(':NERDTree')
				\ ? (g:NERDTree.IsOpen()
				   \ ? ':NERDTreeClose<CR>'
				   \ : ':NERDTreeCWD<CR>')
				\ : exists(':Vifm')
				  \ ? ':call SplitVifm()<CR>' : 'e'

function SplitTerm(mode)
	if a:mode == 'r'
		let l:height = float2nr(&columns / 3)
		execute 'rightbelow vertical terminal ++cols=' . l:height
	else
		let l:width = float2nr(&lines / 3)
		execute 'rightbelow horizontal terminal ++rows=' . l:width
	endif
endfunction
nnoremap <leader>1 :call SplitTerm('b')<CR>
nnoremap <leader>2 :call SplitTerm('r')<CR>

function ChangeListFunction()
	if g:is_list_full
		call UnsetListFunction()
	else
		call SetListFunction()
	endif
endfunction
nnoremap <silent> <C-k> :call ChangeListFunction()<CR>

nnoremap <silent><expr> K exists('*CocHasProvider') && CocHasProvider('hover')
			\ ? CocActionAsync('doHover')
		      \ : exists(':LspHover')
			\ ? ':LspHover<CR>' : 'K'
nnoremap <expr> <leader>r exists('*CocHasProvider') && CocHasProvider('rename')
			\ ? '<Plug>(coc-rename)'
		      \ : exists(':LspRename')
			\ ? ':LspRename<CR>' : 'r'
nnoremap <silent><expr><nowait> gd exists('*CocHasProvider') && CocHasProvider('definition')
				 \ ? '<Plug>(coc-definition)'
			       \ : exists(':LspDefinition')
				 \ ? ':LspDefinition<CR>' : 'gd'
nnoremap <silent><expr><nowait> gr exists('*CocHasProvider') && CocHasProvider('references')
				 \ ? '<Plug>(coc-references)'
			       \ : exists(':LspReferences')
				 \ ? ':LspReferences<CR>' : 'gr'
nnoremap <silent><expr><nowait> ga exists('*CocHasProvider') && CocHasProvider('codeAction')
				 \ ? '<Plug>(coc-codeaction-cursor)'
			       \ : exists(':LspCodeAction')
				 \ ? ':LspCodeAction<CR>' : 'ga'
vnoremap <silent><expr><nowait> ga exists('*CocHasProvider') && CocHasProvider('codeAction')
				 \ ? '<Plug>(coc-codeaction-selected)' : 'ga'

inoremap <silent><expr> <C-j> exists('*coc#pum#visible') && coc#pum#visible()
			    \ ? coc#pum#next(1)
			  \ : pumvisible()
			    \ ? "\<C-n>" : "\<C-j>"
inoremap <silent><expr> <C-k> exists('*coc#pum#visible') && coc#pum#visible()
			    \ ? coc#pum#prev(1)
			  \ : pumvisible()
			    \ ? "\<C-p>" : "\<C-k>"
inoremap <silent><expr> <CR> exists('*coc#pum#visible') && coc#pum#visible()
			   \ ? coc#_select_confirm()
			 \ : exists('*asyncomplete#close_popup') && pumvisible()
			   \ ? asyncomplete#close_popup() : "\<CR>"
inoremap <silent><expr> <TAB> exists('*coc#pum#visible') && coc#pum#visible()
			    \ ? coc#_select_confirm()
			  \ : exists('*asyncomplete#close_popup') && pumvisible()
			    \ ? asyncomplete#close_popup() : "\<TAB>"

function SetNumbersFunction()
	set number
	set cursorline
	set relativenumber
endfunction
command SN call SetNumbersFunction()

function UnsetNumbersFunction()
	set number &
	set cursorline &
	set relativenumber &
endfunction
command USN call UnsetNumbersFunction()

function SetListFunction()
	let g:is_list_full = 1
	set listchars=tab:-->,space:⋅,trail:␣,precedes:⟨,extends:⟩
endfunction
command SL call SetListFunction()

function UnsetListFunction()
	let g:is_list_full = 0
	set listchars=tab:\ \ ,space:\ ,trail:␣,precedes:⟨,extends:⟩
endfunction
command USL call UnsetListFunction()

function CheckGNUStyle()
	if g:c_style == "GNU"
		setlocal cindent
		setlocal cinoptions=(0,f0,t0,:s,^-s,>2s,{s,Ws,n-s
	endif
endfunction

function SetIndent(spaces, tabs, noexpand)
	let l:shift = a:spaces > 0 ? a:spaces : 4
	let l:tabs = a:tabs > 0 ? a:tabs : 8

	let &shiftwidth = l:shift
	let &softtabstop = l:shift
	let &tabstop = l:tabs

	if a:noexpand
		set noexpandtab
	else
		set expandtab
	endif
endfunction

command S2 call SetIndent(2, 0, v:false)
command S4 call SetIndent(4, 0, v:false)
command S8 call SetIndent(8, 0, v:false)
command T2 call SetIndent(2, 2, v:true)
command T4 call SetIndent(4, 4, v:true)
command T8 call SetIndent(8, 8, v:true)
command M2 call SetIndent(2, 4, v:true)
command M4 call SetIndent(4, 8, v:true)
command MG call SetIndent(2, 8, v:true)

function GetMode()
	let l:mode = mode()
	return get({ 'n'      : 'NORMAL',
		   \ 'i'      : 'INSERT',
		   \ 'c'      : 'COMMAND',
		   \ 't'      : 'TERMINAL',
		   \ 'v'      : 'VISUAL',
		   \ 'V'      : 'VLINE',
		   \ "\<C-V>" : 'VBLOCK' },
		   \ l:mode, 'err: unknown mode: ' . l:mode) . ' '
endfunction

function GetSel()
	let l:mode = mode()

	if !(l:mode == 'v' || l:mode == 'V')
		return ''
	endif

	let l:starts = line('v')
	let l:ends = line('.')
	let l:lines = l:starts <= l:ends
		  \ ? l:ends - l:starts + 1
		  \ : l:starts - l:ends + 1

	if l:lines <= 1
		return ':' . wordcount().visual_chars . 'C'
	else
		return ':' . l:lines . 'L'
	endif
endfunction

function GetIndent()
	let l:result = &shiftwidth . '/' . &tabstop . '-'
	if &expandtab
		return l:result . 'S '
	elseif (&shiftwidth != &tabstop)
		return l:result . 'M '
	else
		return l:result . 'T '
	endif
endfunction

function GetLang()
	return (&iminsert == 0 ? 'iEN|' : 'iRU|')
	   \ . (&imsearch == 0 ? 'sEN ' : 'sRU ')
endfunction

exec 'highlight MyCustomStatus'
 \ . ' guifg=' . synIDattr(hlID('Normal'), 'fg', 'gui')
 \ . ' guibg=' . synIDattr(hlID('CursorColumn'), 'bg', 'gui')

set statusline=
set statusline+=%#MyCustomStatus#\ %{GetMode()}
set statusline+=%#LineNr#\ %f\ %y\ %l%{GetSel()}
set statusline+=%=
set statusline+=\ %{GetIndent()}
set statusline+=%#MyCustomStatus#
set statusline+=\ %{GetLang()}

autocmd VimEnter * call SetNumbersFunction() | call UnsetListFunction()
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufNewFile,BufRead *.its set filetype=dts
autocmd FileType c,cpp call CheckGNUStyle()
