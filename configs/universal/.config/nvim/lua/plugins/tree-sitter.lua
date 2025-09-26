-- NOTE: It's required to put `tree-sitter` binary on PATH.
--       You can get it here: https://github.com/tree-sitter/tree-sitter/releases

return {
  'nvim-treesitter/nvim-treesitter', branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    local ts = require('nvim-treesitter')

    ts.setup { install_dir = vim.fn.stdpath('data') .. '/site/treesitter' }

    vim.filetype.add {
      extension = {
        HC = 'hc',
        sh = 'bash',
        tmux = 'bash',
        json = 'jsonc',
        editorconfig = 'editorconfig',
      }
    }

    local ensure_installed = {
      'c', 'cpp', 'cmake', 'meson', 'python', 'go', 'rust',
      'xml', 'json', 'vimdoc', 'comment',
      'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
      -- for noice:
      'vim', 'lua', 'bash', 'regex', 'markdown', 'markdown_inline'
    }

    local ignored = {
      make = true
    }

    local renames = {
      devicetree = 'dts',
      json = 'jsonc'
    }

    local available = {}
    for _, parser in ipairs(ts.get_available()) do
      parser = renames[parser] or parser
      if not ignored[parser] then
        available[#available + 1] = parser
      end
    end

    local installed = {}
    for _, parser in ipairs(ts.get_installed()) do
      parser = renames[parser] or parser
      installed[#installed + 1] = parser
    end

    ts.install(ensure_installed)

    require('config.globals').funcs.au {
      name = 'FileType',
      data = {
        pattern = available,
        callback = function(ev)
          local ft = vim.bo[ev.buf].filetype
          if vim.list_contains(installed, ft) then
            vim.treesitter.start()
            if vim.list_contains({ 'norg', 'neorg' }, ft) then -- 'markdown'
              vim.opt_local.foldmethod = 'expr'
              vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
              vim.opt_local.indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
            end
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
