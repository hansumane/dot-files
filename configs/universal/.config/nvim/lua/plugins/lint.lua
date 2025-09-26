return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    local funcs = require('config.globals').funcs

    local linters = {
      flake8 = {
        ft = 'python',
        args_force = false,
        args = { '--max-line-length', '120' },
        parser = nil
      },
      checkpatch = {
        ft = 'c',
        args_force = true,
        args = {
          '--no-tree',
          '--no-signoff', '--show-types', '--strict', '--terse', '--file',
          '--ignore', table.concat({
            'PREFER_KERNEL_TYPES',
            'SPDX_LICENSE_TAG', 'FILE_PATH_CHANGES', 'COMMIT_MESSAGE'
          }, ',')
        },
        parser = require('lint.parser').from_pattern(
          '([^:]+):(%d+): (%a+):([%a_]+): (.+)',
          { 'file', 'lnum', 'severity', 'code', 'message' },
          { ['ERROR'] = vim.diagnostic.severity.ERROR,
            ['WARNING'] = vim.diagnostic.severity.WARN,
            ['CHECK'] = vim.diagnostic.severity.INFO },
          { source = 'checkpatch' }
        )
      }
    }

    local remove_lint_diagnostic = function()
      for i, ns in pairs(vim.diagnostic.get_namespaces()) do
        if linters[ns.name] ~= nil then
          vim.diagnostic.reset(i)
        end
      end
    end

    local lint = require('lint')

    for linter, settings in pairs(linters) do
      if settings.args_force then
        lint.linters[linter].args = settings.args
      else
        vim.list_extend(lint.linters[linter].args, settings.args)
      end
      if settings.parser then
        lint.linters[linter].parser = settings.parser
      end
      lint.linters_by_ft[settings.ft] = { linter }
    end

    local map = require('config.globals').funcs.map

    map { mods = 'n', map = '<leader>ll', cmd = lint.try_lint,
          opts = { desc = 'Lint: Try Lint' } }

    map { mods = 'n', map = '<leader>lh', cmd = remove_lint_diagnostic,
          opts = { desc = 'Lint: Hide Lint' } }
  end
}
