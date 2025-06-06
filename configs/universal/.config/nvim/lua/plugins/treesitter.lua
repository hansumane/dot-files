-- NOTE: it's required to put `tree-sitter` binary on PATH.
--       you can get it here: https://github.com/tree-sitter/tree-sitter/releases

return {
  'nvim-treesitter/nvim-treesitter', branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')

    ts.setup { install_dir = vim.fn.stdpath('data') .. '/site' }

    local ensure_installed = {
      'c', 'cpp', 'python', 'json', 'vimdoc', 'comment',
      'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
      -- for noice:
      'vim', 'regex', 'lua', 'bash', 'markdown', 'markdown_inline'
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
              vim.notify('TreeSitter: ' .. ft .. ' parser is available, but not installed',
                         vim.log.levels.WARN)
            end)
          end
        end
      }
    }
  end
}

--[[
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      highlight = { enable = true },
      ignore_install = { 'make', 'tmux' },
      ensure_installed = {
        'c', 'python', 'vimdoc', 'comment',
        'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
        -- for noice:
        'vim', 'regex', 'lua', 'bash', 'markdown', 'markdown_inline'
      }
    }
  end
}
--]]
