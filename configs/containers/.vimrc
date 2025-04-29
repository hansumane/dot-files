" Enable hidden buffers with unsaved changes.
" set hidden

set shell=/bin/bash
set nobackup
set nowritebackup
set noundofile
set termguicolors

colorscheme molokai

nnoremap <M-b> :CtrlPBuffer<CR>

" FIXME Get rid of hard-coded path.
let g:syntastic_c_checkpatch_exec = '/lib/modules/6.10.0-angtel6-g07dc1c8232ad/source/scripts/checkpatch.pl'
let g:syntastic_c_checkpatch_args = join([
	\ '--strict',
	\ '--max-line-length=90',
	\ '--ignore',
	\ 'SPDX_LICENSE_TAG,CONCATENATED_STRING,PREFER_KERNEL_TYPES,SPLIT_STRING',
	\ ])

" Remove Makefile from root marker patterns.
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'package.json']

nnoremap <F2> :vertical Vifm<CR>

let g:vifm_embed_term = 1
let g:vifm_embed_split = 1
let g:vifm_exec_args = "-c :only"

call plug#begin('~/.vim/plugged')

" Put plugins here.
" Plug 'vifm/vifm.vim'

call plug#end()
