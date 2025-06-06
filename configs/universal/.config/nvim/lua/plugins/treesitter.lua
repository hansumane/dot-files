-- NOTE: It's required to put `tree-sitter` binary on PATH.
--       You can get it here: https://github.com/tree-sitter/tree-sitter/releases
-- FIXME: For some reason, after the plugin update, some parsers/queries may not work.
--        Unfortunately, it's required to reinstall those parsers/queries manually.
--        When unsure, just reinstall all the parsers/queries -_-

return {
  'nvim-treesitter/nvim-treesitter', branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')

    ts.setup { install_dir = vim.fn.stdpath('data') .. '/site/treesitter' }

    vim.filetype.add {
      extension = {
        sh = 'bash'
      }
    }

    local ensure_installed = {
      'c', 'cpp', 'make', 'cmake', 'meson', 'python',
      'xml', 'json', 'vimdoc', 'comment',
      'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
      -- for noice:
      'vim', 'lua', 'bash', 'regex', 'markdown', 'markdown_inline'
    }

    ts.install(ensure_installed)

    require('autocmds').now {
      name = 'FileType',
      data = {
        pattern = ts.get_available(),
        callback = function(ev)
          local ft = vim.bo[ev.buf].filetype

          if vim.list_contains(ts.get_installed(), ft) then
            vim.treesitter.start()
          else
            vim.schedule(function()
              local msg = "TreeSitter: '%s' parser is available, but not installed"
              vim.notify(msg:format(ft), vim.log.levels.WARN)
            end)
          end
        end
      }
    }
  end
}

--[[
-- Configuration for older version of the plugin, on `master` branch
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      highlight = { enable = true },
      ignore_install = { 'make', 'tmux' },
      ensure_installed = {
        'c', 'cpp', 'make', 'cmake', 'meson', 'python',
        'xml', 'json', 'vimdoc', 'comment',
        'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
        -- for noice:
        'vim', 'lua', 'bash', 'regex', 'markdown', 'markdown_inline'
      }
    }
  end
}
--]]
