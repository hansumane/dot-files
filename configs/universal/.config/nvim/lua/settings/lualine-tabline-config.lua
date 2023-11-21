local function config ()
  require'tabline'.setup{
    enable = true,
    options = {
      show_devicons = true,
      modified_icons = '● ',
      section_separators = {'', ''},
      component_separators = {'|', '|'},
    },
    vim.cmd[[
      set guioptions-=e
      set sessionoptions+=tabpages,globals
    ]]
  }

  vim.keymap.set('n', '<S-h>', '<cmd>TablineBufferPrevious<CR>')
  vim.keymap.set('n', '<S-l>', '<cmd>TablineBufferNext<CR>')
  vim.keymap.set('n', '<S-c>', '<cmd>bd<CR>')
  vim.keymap.set('n', '<C-c>', '<cmd>%bd|e#|bd#<CR>')
end

return {
  'kdheepak/tabline.nvim',
  config = config,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',
  },
}
