return {
  'MeanderingProgrammer/markdown.nvim', name = 'render-markdown',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  config = function()
    require('render-markdown').setup {
      completions = { lsp = { enabled = true } }
    }
  end
}
