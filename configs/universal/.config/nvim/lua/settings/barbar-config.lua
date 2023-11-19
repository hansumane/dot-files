return {
  'romgrk/barbar.nvim',
  config = function ()
    vim.g.barbar_auto_setup = false
    require'barbar'.setup{animation = false}
    vim.keymap.set('n', '<S-h>', ':BufferPrevious<CR>')
    vim.keymap.set('n', '<S-l>', ':BufferNext<CR>')
    vim.keymap.set('n', '<S-c>', ':BufferClose<CR>')
    vim.keymap.set('n', '<C-c>', ':BufferCloseAllButCurrent<CR>')
  end
}
