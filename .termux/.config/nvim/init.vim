set number
set relativenumber

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

function! TabsFunc8()
	set shiftwidth=8
	set tabstop=8
	set expandtab &
	echom "indent: Tab"
endfunction

function! TabsFunc4()
	set shiftwidth=4
	set tabstop=4
	set expandtab &
	echom "indent: Tab"
endfunction

function! SpaceFunc4()
	set shiftwidth=4
	set tabstop=4
	set expandtab
	echom "indent: 4xSpace"
endfunction

function! SpaceFunc2()
	set shiftwidth=2
	set tabstop=2
	set expandtab
	echom "indent: 2xSpace"
endfunction

command Tab call TabsFunc8()
command Tabs call TabsFunc4()
command Spaces call SpaceFunc4()
command Mark call SpaceFunc2()

Spaces

au BufEnter,Bufnew *.html Mark
au BufEnter,Bufnew *.xml Mark
au BufEnter,Bufnew *.yml Mark
au BufEnter,Bufnew *.c Tab
au BufEnter,Bufnew *.h Tab
au BufEnter,Bufnew *.cpp Tab
au BufEnter,Bufnew *.cxx Tab
au BufEnter,Bufnew *.vim Tab
au BufEnter,Bufnew Makefile Tab
