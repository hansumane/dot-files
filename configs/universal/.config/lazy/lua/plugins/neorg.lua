-- NOTE: requires norg tree-sitter parser to be installed manually,
--       because it's not on nvim-treesitter/main yet.
--       link: https://github.com/nvim-neorg/tree-sitter-norg.git
--       commit: d89d95af13d409f30a6c7676387bde311ec4a2c8

return {
  'nvim-neorg/neorg',
  lazy = false,
  config = function()
    require('neorg').setup()
    require('config.globals').funcs.au {
      name = 'FileType',
      data = {
        pattern = { 'norg', 'neorg' },
        callback = function()
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo.indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
        end
      }
    }
  end
}
