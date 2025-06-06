-- TODO: replace with lualine or something
return {
  setup = function()
    vim.cmd[[
	function TempGetMode()
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

	function TempGetSel()
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

	function TempGetIndent()
		let l:result = &shiftwidth . '/' . &tabstop . '-'
		if &expandtab
			return l:result . 'S '
		elseif (&shiftwidth != &tabstop)
			return l:result . 'M '
		else
			return l:result . 'T '
		endif
	endfunction

	function TempGetLang()
		return (&iminsert == 0 ? 'iEN|' : 'iRU|')
		   \ . (&imsearch == 0 ? 'sEN ' : 'sRU ')
	endfunction

	exec 'highlight MyCustomStatus'
	 \ . ' guifg=' . synIDattr(hlID('Normal'), 'fg', 'gui')
	 \ . ' guibg=' . synIDattr(hlID('CursorColumn'), 'bg', 'gui')

	set statusline=%#LineNr#%=\ %l%{TempGetSel()}%=
	autocmd FileType * setlocal statusline=%#MyCustomStatus#\ %{TempGetMode()}%#LineNr#\ %f\ %y\ %l%{TempGetSel()}%=\ %{TempGetIndent()}%#MyCustomStatus#\ %{TempGetLang()}
    ]]
  end
}
