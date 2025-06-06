-- TODO: make insert on terminal open and escape on terminal close

return {
  'akinsho/toggleterm.nvim', version = '*',
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup()

    local map = require('mappings').now

    map { mods = 'n', map = '<C-t>',
          cmd = ':ToggleTerm<CR><C-\\><C-n>',
          opts = { silent = true, desc = 'ToggleTerm: Open' } }

    map { mods = 't', map = '<C-t>',
          cmd = '<C-\\><C-n>:ToggleTerm<CR>',
          opts = { silent = true, desc = 'ToggleTerm: Close' } }
  end
}
