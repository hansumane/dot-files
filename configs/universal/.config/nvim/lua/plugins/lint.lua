local linters = {
  flake8 = {
    ft = 'python',
    -- TODO: Maybe set max-line-length from editorconfig
    args = { '--max-line-length', '120' }
  }
}

local remove_lint_diagnostic = function()
  for i, ns in pairs(vim.diagnostic.get_namespaces()) do
    if linters[ns.name] ~= nil then
      vim.diagnostic.reset(i)
    end
  end
end

return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    local lint = require 'lint'

    for linter, settings in pairs(linters) do
      vim.list_extend(lint.linters[linter].args, settings.args)
      lint.linters_by_ft = {
        [settings.ft] = { linter }
      }
    end

    local map = require('mappings').now
    map { mods = 'n', map = '<leader>ll', opts = { desc = 'Lint: Try Lint' }, cmd = lint.try_lint }
    map { mods = 'n', map = '<leader>lh', opts = { desc = 'Lint: Hide Lint' }, cmd = remove_lint_diagnostic }
  end
}
