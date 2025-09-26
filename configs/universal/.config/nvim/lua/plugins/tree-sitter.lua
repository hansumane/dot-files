-- NOTE: It's required to put `tree-sitter` binary on PATH.
--       You can get it here: https://github.com/tree-sitter/tree-sitter/releases
--       Or: $ cargo install tree-sitter-cli

return {
  'nvim-treesitter/nvim-treesitter', branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    local ts = require('nvim-treesitter')

    ts.setup { install_dir = vim.fn.stdpath('data') .. '/site/treesitter' }

    -- file.<extension> = '<filetype>'
    vim.filetype.add {
      extension = {
        HC = 'hc',
        sh = 'bash',
        bb = 'bash',
        bbappend = 'bash',
        tmux = 'bash',
        json = 'jsonc',
        gitconfig = 'gitconfig',
        editorconfig = 'editorconfig',
      }
    }

    local ensure_installed = {
      -- programming languages:
      'c', 'cpp',
      'python',
      'rust',
      'go',
      -- scripting languages:
      'perl',
      'zsh',
      -- build systems:
      'cmake',
      'meson',
      -- markup, config, etc...
      'xml',
      'toml',
      'json',
      'vimdoc',
      'comment',
      'editorconfig',
      -- git:
      'gitcommit',
      'gitignore',
      'gitattributes',
      'git_config',
      'git_rebase',
      -- for noice:
      'vim',
      'lua',
      'bash',
      'regex',
      -- for render-markdown:
      'markdown',
      'markdown_inline',
      'latex',
      'html',
      'yaml',
    }

    local ignored = {
      bitbake = true,
      make = true,
    }

    -- <tree-sitter name> = '<filetype>'
    local renames = {
      devicetree = 'dts',
      json = 'jsonc',
      -- git_config = 'gitconfig',
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
              local msg = 'TreeSitter: "%s" parser is available, but not installed'
              vim.notify(msg:format(ft), vim.log.levels.WARN)
            end)
          end
        end
      }
    }
  end
}
