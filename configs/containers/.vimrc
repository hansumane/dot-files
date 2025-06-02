" call plug#begin()
" 	" - themes -
" 	Plug 'tomasr/molokai'
" 	" - functional -
" 	Plug 'preservim/nerdtree'
" 	Plug 'airblade/vim-rooter'
" 	Plug 'ctrlpvim/ctrlp.vim'
" 	Plug 'tpope/vim-fugitive'
" 	" - code -
" 	Plug 'vim-syntastic/syntastic'
" 	Plug 'editorconfig/editorconfig-vim'
" 	" - LSP -
" 	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" 	" = alternative =
" 	" - functional -
" 	" Plug 'vifm/vifm.vim'
" 	" - LSP -
" 	" Plug 'prabirshrestha/vim-lsp'
" 	" Plug 'mattn/vim-lsp-settings'
" 	" Plug 'prabirshrestha/asyncomplete.vim'
" 	" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" call plug#end()

set list
set hidden
set termguicolors

set nobackup
set nowritebackup
set noundofile
set noswapfile
set noshowmode

set mouse=nv
set scrolloff=3
set laststatus=2
set updatetime=300

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

if has('nvim')
	set clipboard+=unnamedplus
endif

set background=dark
colorscheme molokai

let g:vifm_embed_term = 1
let g:vifm_embed_split = 1
let g:vifm_exec_args = '-c :only'

let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

let g:rooter_patterns = ['.git', '.vi_project_root']
let g:rooter_change_directory_for_non_project_files = 'current'

let g:syntastic_c_checkpatch_exec = '/usr/local/bin/checkpatch.pl'
let g:syntastic_c_checkpatch_args = join([
	\ '--no-tree', '--no-signoff', '--show-types', '--strict',
	\ '--max-line-length=90', '--ignore',
	\ 'SPDX_LICENSE_TAG,PREFER_KERNEL_TYPES',
	\ ])

cnoremap <C-\> <C-6>
inoremap <C-\> <C-6>
inoremap <C-r> <C-v><C-i>

let mapleader = ' '
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>c :bd<CR>
nnoremap <leader>j :noh<CR>
vnoremap <leader>k :sort<CR>
nnoremap <leader>l :CocList<CR>

function SplitVifm()
	let l:width = float2nr(&columns / 3)
	execute 'leftabove vertical ' . l:width . ' Vifm'
endfunction
nnoremap <expr> <leader>e exists(':NERDTree')
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

" FIXME: implement for vim-lsp too
nnoremap <silent><expr><nowait> gd exists('*CocHasProvider') && CocHasProvider('definition')
			      \ ? '<Plug>(coc-definition)' : 'gd'
nnoremap <silent><expr><nowait> gr exists('*CocHasProvider') && CocHasProvider('references')
			      \ ? '<Plug>(coc-references)' : 'gr'

inoremap <silent><expr> <C-j> exists('*coc#pum#visible') && coc#pum#visible()
			    \ ? coc#pum#next(1)
			  \ : pumvisible()
			    \ ? "\<C-n>" : "\<C-j>"
inoremap <silent><expr> <C-k> exists('*coc#pum#visible') && coc#pum#visible()
			    \ ? coc#pum#prev(1)
			  \ : pumvisible()
			    \ ? "\<C-p>" : "\<C-k>"
inoremap <silent><expr> <cr> exists('*coc#pum#visible') && coc#pum#visible()
			   \ ? coc#_select_confirm()
			 \ : exists('*asyncomplete#close_popup') && pumvisible()
			   \ ? asyncomplete#close_popup() : "\<cr>"
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

function SetIndent(n, mode)
	let &shiftwidth = a:n
	let &tabstop = a:n
	let &softtabstop = a:n

	if a:mode=='tabs'
		set noexpandtab
	elseif a:mode=='mixed'
		let &tabstop=2 * a:n
		set noexpandtab
	else
		set expandtab
	endif
endfunction

command S2 call SetIndent(2, '')
command S4 call SetIndent(4, '')
command T4 call SetIndent(4, 'tabs')
command T8 call SetIndent(8, 'tabs')
command M2 call SetIndent(2, 'mixed')
command M4 call SetIndent(4, 'mixed')

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

set statusline=
set statusline+=%#CursorColumn#\ %{GetMode()}
set statusline+=%#LineNr#\ %f\ %y
set statusline+=%=
set statusline+=\ %l:%c
set statusline+=\ %{GetIndent()}
set statusline+=%#CursorColumn#
set statusline+=\ %{GetLang()}

autocmd VimEnter * call SetNumbersFunction() | call UnsetListFunction()
autocmd BufNewFile,BufRead *.its set filetype=dts
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
