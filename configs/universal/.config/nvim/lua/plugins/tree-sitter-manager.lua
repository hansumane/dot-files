-- NOTE: It's required to put `tree-sitter` binary on PATH.
--       You can get it here: https://github.com/tree-sitter/tree-sitter/releases
--       Or: $ cargo install tree-sitter-cli

return {
  'romus204/tree-sitter-manager.nvim',
  lazy = false,
  opts = {
    ensure_installed = {
      'c', 'lua', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
      'python', 'rust', 'go', 'nim',
      'bash', 'fish', 'json', 'devicetree', 'yang',
    },
    languages = {
      c = {
        install_info = {
          revision = '420dd222adbb8055115786832bac04f071c85329',
          url = 'https://github.com/hansumane/tree-sitter-c'
        }
      },
      devicetree = {
        install_info = {
          revision = 'e78bf56f206cb47bee28a217423acb651e076848',
          url = 'https://github.com/joelspadin/tree-sitter-devicetree'
        }
      },
    }
  }
}
