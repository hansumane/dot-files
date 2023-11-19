local config = function ()
  local lspconfig = require'lspconfig'
  lspconfig.lua_ls.setup{}
  lspconfig.clangd.setup{}
  lspconfig.pyright.setup{}

  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.declaration, {})
  vim.keymap.set('n', '<leader>lD', vim.lsp.buf.definition, {})
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', '<leader>lr', require'telescope.builtin'.lsp_references, {})
end

return {
  {
    'williamboman/mason.nvim',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        'lua_ls',
        'clangd',
        'pyright',
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    config = config,
  },
}
