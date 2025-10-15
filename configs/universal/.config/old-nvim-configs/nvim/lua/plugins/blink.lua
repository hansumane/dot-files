return {
  'Saghen/blink.cmp', version = '*',
  dependencies = {
    'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' }
  },
  event = 'VeryLazy',
  config = function()
    require('blink.cmp').setup {
      cmdline = { enabled = false },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lsp = { fallbacks = {} } ,
          path = { opts = { show_hidden_files_by_default = true } }
        }
      },
      keymap = {
        preset = 'none',
        ['<CR>'] = { 'accept', 'fallback' },
        ['<TAB>'] = { 'accept', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' }
      },
      completion = {
        menu = {
          scrolloff = 1,
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'source_name' }
            }
          }
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true
          }
        }
      }
    }
    require('luasnip.loaders.from_vscode').lazy_load()
  end
}
