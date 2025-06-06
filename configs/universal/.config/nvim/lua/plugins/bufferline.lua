local buf_cycle_prev_search = function()
  if vim.fn.getreg('/') ~= '' then
    vim.cmd('normal! N')
  else
    vim.cmd('BufferLineMovePrev')
  end
end

local prev_search = ''
local no_hl_search = function()
  vim.cmd('nohlsearch')
  prev_search = vim.fn.getreg('/')
  vim.fn.setreg('/', '')
end
local next_search = function()
  if vim.fn.getreg('/') == '' then
    vim.fn.setreg('/', prev_search)
  end
  vim.cmd('normal! n')
end

return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        mode = 'buffers',
        sort_by = 'insert_after_current',
        indicator = { icon = '', style = 'none' },
        modified_icon = '●',
        buffer_close_icon = '',
        close_icon = '',
        truncate_names = false,
        tab_size = 0,
        -- TODO:
        -- close_command = buf_kill
        -- right_mouse_command = buf_kill
      }
    }

    local map = require('mappings').now

    map { mods = 'n', map = '[t', cmd = ':tabprevious<CR>',
          opts = { desc = 'Previous Tab' } }

    map { mods = 'n', map = ']t', cmd = ':tabnext<CR>',
          opts = { desc = 'Next Tab' } }

    map { mods = 'n', map = 'L', cmd = ':BufferLineCycleNext<CR>',
          opts = { silent = true, desc = 'BufferLine: Next Buffer' } }

    map { mods = 'n', map = 'H', cmd = ':BufferLineCyclePrev<CR>',
          opts = { silent = true, desc = 'BufferLine: Previous Buffer' } }

    map { mods = 'n', map = 'M', cmd = ':BufferLineMoveNext<CR>',
          opts = { silent = true, desc = 'BufferLine: Move Buffer Right' } }

    map { mods = 'n', map = 'N', cmd = buf_cycle_prev_search,
          opts = { noremap = true, desc = 'BufferLine: Move Buffer Left or Previous Search' } }

    map { mods = 'n', map = 'n', cmd = next_search,
          opts = { noremap = true, desc = 'Go to Next Search' } }

    map { mods = 'n', map = '<leader>j', cmd = no_hl_search,
          opts = { desc = 'nohlsearch' } }
  end
}
