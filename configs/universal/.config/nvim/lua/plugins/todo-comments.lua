return {
  'folke/todo-comments.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('todo-comments').setup {
      keywords = {
        -- FIXME
        -- ERROR
        -- FIXME: test
        -- ERROR: test
        -- ISSUE: test
        -- BUG: test
        FIX  = { icon = ' ', color = 'error',
                 alt = { 'FIXME', 'ERROR', 'ISSUE', 'BUG' } },
        -- WARN
        -- WARN: test
        -- WARNING: test
        -- HACK: test
        WARN = { icon = ' ', color = 'warning',
                 alt = { 'WARNING', 'HACK' } },
        -- REV
        -- REV: test
        -- REVIEW: test
        REV  = { icon = ' ', color = 'review',
                 alt = { 'REVIEW' } },
        -- NOTE
        -- NOTE: test
        -- INFO: test
        -- PERF: test
        NOTE = { icon = ' ', color = 'note',
                 alt = { 'INFO', 'PERF' } },
        PERF = {},
        -- TODO
        -- TODO: test
        TODO = { icon = ' ', color = 'todo',
                 alt = {} }
      },
      colors = {
        error   = { 'DiagnosticError' },
        warning = { 'DiagnosticWarn' },
        review  = { 'DiagnosticOk' },
        note    = { 'DiagnosticInfo' },
        todo    = { 'Todo' }
      }
    }

    require('mappings').now { mods = 'n', map = '<leader>st',
                              opts = { silent = true, desc = 'Trouble: TODO' },
                              cmd = ':Trouble todo toggle focus=true filter.buf=0<CR>' }
  end
}
