set number
set relativenumber

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

function! TabsFunc()
	set shiftwidth=8
	set tabstop=8
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
	set tabstop=4
	set expandtab
	echom "indent: 2xSpace"
endfunction

command Tabs call TabsFunc()
command Spaces call SpaceFunc4()
command Mark call SpaceFunc2()

Spaces
