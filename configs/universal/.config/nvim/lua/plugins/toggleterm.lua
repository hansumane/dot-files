-- TODO: make insert on terminal open and escape on terminal close
return {
  'akinsho/toggleterm.nvim', version = '*',
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup()

    local map = require('mappings').now

    map { mods = 'n', map = '<C-t>', opts = { silent = true },
          cmd = ':ToggleTerm<CR><C-\\><C-n>' }

    map { mods = 't', map = '<C-t>', opts = { silent = true },
          cmd = '<C-\\><C-n>:ToggleTerm<CR>' }
  end
}
