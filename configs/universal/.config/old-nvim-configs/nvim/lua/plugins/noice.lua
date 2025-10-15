return {
  'folke/noice.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' }, -- 'rcarriga/nvim-notify' },
  priority = 2000 - 3, lazy = false,
  config = function()
    -- require('notify').setup {
    --   render = 'compact',
    --   stages = 'static'
    -- }

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
        override = {
          ['vim.lsp.util.stylize_markdown'] = true,
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true
        }
      }
    }
  end
}
