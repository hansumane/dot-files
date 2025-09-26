return {
  'folke/noice.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  lazy = false,
  config = function()
    require('noice').setup {
      cmdline = {
        view = 'cmdline',
        format = { input = { view = 'cmdline' } }
      },
      presets = {
        bottom_search = true,
        long_message_to_split = true
      },
      lsp = {
        signature = { auto_open = { enabled = false } },
        override = {
          ['vim.lsp.util.stylize_markdown'] = true,
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true
        }
      }
    }
  end
}
