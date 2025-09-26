local globals = require('config.globals')
local vars = globals.vars
local funcs = globals.funcs

require('editorconfig').properties.max_line_length = function(_, val)
  local n = tonumber(val)
  if n then
    funcs.update_cc(nil, n + 1)
  else
    assert(val == 'off', 'editorconfig: max_line_length: not number or "off"')
    funcs.update_cc(nil, vars.cd_init)
  end
end

vim.filetype.add {
  extension = {
    HC = 'hc',
    json = 'jsonc',
    gitconfig = 'gitconfig',
    editorconfig = 'editorconfig',
  }
}

vim.opt.rtp:append(vim.fn.stdpath('data') .. '/lazy/tree-sitter-manager.nvim')
local ok, ft = pcall(require, 'tree-sitter-manager.filetypes')
if ok then
  ft.bash = { 'sh', 'zsh', 'bash', 'bitbake' }
end
