set number
set relativenumber

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

au BufEnter,Bufnew *.html Mark
au BufEnter,Bufnew *.xml Mark
au BufEnter,Bufnew *.yml Mark
au BufEnter,Bufnew *.c Tabs
au BufEnter,Bufnew *.h Tabs
au BufEnter,Bufnew *.cpp Tabs
au BufEnter,Bufnew *.cxx Tabs
au BufEnter,Bufnew *.vim Tabs
au BufEnter,Bufnew Makefile Tabs
