return {
  'MeanderingProgrammer/markdown.nvim', name = 'render-markdown',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  ft = 'markdown',
  config = function()
    require('render-markdown').setup {
      completions = { lsp = { enabled = true } }
    }
  end
}
