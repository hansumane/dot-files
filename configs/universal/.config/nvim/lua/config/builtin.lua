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

local filetypes = {
  bash = { 'sh', 'zsh', 'bash', 'bitbake' },
  devicetree = { 'dts' },
  json = { 'jsonc' },
}

for lang, ft in pairs(filetypes) do
  vim.treesitter.language.register(lang, ft)
end

require('config.globals').funcs.au {
  name = 'FileType',
  data = {
    pattern = {
      "c", "lua", "markdown", "query", "vim",
      "sh", "zsh", "bash", "bitbake", "fish",
      "jsonc", "dts", "yang", "python", "go", "rust",
    },
    callback = function()
      vim.treesitter.start()
    end
  }
}
