local config = function ()
  vim.cmd [[
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
  ]]

  vim.g.lightline = {
    colorscheme = 'catppuccin',
    active = {
      left = {
        {'mode', 'paste'},
        {'readonly', 'filename', 'modified'},
      },
      right = {
        {'lineinfo'},
        {'percent'},
        {'fileformat', 'fileencoding', 'indentv', 'filetype'},
      },
    },
    component_function = {
      indentv = 'GetIndent',
    },
  }
end

return {
  'itchyny/lightline.vim',
  config = config,
}
