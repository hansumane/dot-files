set number
set relativenumber

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

function! TabsFunc()
	set shiftwidth=4
	set tabstop=4
	set expandtab &
	echom "indent: Tab"
endfunction

function! SpaceFunc()
	set shiftwidth=4
	set tabstop=4
	set expandtab
	echom "indent: Space"
endfunction

command Tabs call TabsFunc()
command Spaces call SpaceFunc()

Tabs
