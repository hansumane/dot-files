if vim.g.vscode then
  require('config.code')
else
  require('config.init')
  require('config.keymaps')
  require('config.autocmds')
  require('config.builtin')
  require('config.lazy')
end
