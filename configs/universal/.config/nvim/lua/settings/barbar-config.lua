return {
  'romgrk/barbar.nvim',
  config = function ()
    vim.g.barbar_auto_setup = false
    require'barbar'.setup{animation = false}
    vim.keymap.set('n', '<S-h>', '<cmd>BufferPrevious<CR>')
    vim.keymap.set('n', '<S-l>', '<cmd>BufferNext<CR>')
    vim.keymap.set('n', '<S-c>', '<cmd>BufferClose<CR>')
    vim.keymap.set('n', '<C-c>', '<cmd>BufferCloseAllButCurrent<CR>')
  end
}
