function! TabsFunc()
	set shiftwidth=8
	set tabstop=8
	set expandtab &
	echo "indent: Tab"
endfunction

function! SpaceFunc()
	set shiftwidth=4
	set tabstop=4
	set expandtab
	echo "indent: Space"
endfunction

command Tabs call TabsFunc()
command Spaces call SpaceFunc()

set number
set relativenumber

Tabs
