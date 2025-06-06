local get_sel = function()
  if not vim.fn.mode():find('[vV]') then
    return ''
  end

  local starts = vim.fn.line('v')
  local ends = vim.fn.line('.')
  local lines = starts <= ends
            and ends - starts + 1
             or starts - ends + 1

  if lines <= 1 then
    return vim.fn.wordcount().visual_chars .. 'C'
  else
    return lines .. 'L'
  end
end

local get_indent = function()
  local shift = vim.opt.shiftwidth:get()
  local tabst = vim.opt.tabstop:get()
  local expand = vim.opt.expandtab:get()
  local result = shift .. '/' .. tabst .. '-'
  if expand then
    result = result .. 'S'
  elseif shift ~= tabst then
    result = result .. 'M'
  else
    result = result .. 'T'
  end
  return result
end

local get_lang_insert = function()
  return vim.opt.iminsert:get() == 0 and 'iEN' or 'iRU'
end
local get_lang_search = function()
  return vim.opt.imsearch:get() == 0 and 'sEN' or 'sRU'
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  priority = 2000 - 2, lazy = false,
  opts = {
    options = { icons_enabled = false },
    extensions = {},
    tabline = {},
    sections = {
      lualine_a = { 'mode',            get_sel         },
      lualine_b = { 'filename',       'filetype'       },
      lualine_c = {                                    },
      lualine_x = {  get_indent                        },
      lualine_y = { 'branch'                           },
      lualine_z = {  get_lang_insert,  get_lang_search }
    },
    inactive_sections = {
      lualine_a = {            },
      lualine_b = {            },
      lualine_c = { 'filename' },
      lualine_x = { 'filetype' },
      lualine_y = {            },
      lualine_z = {            }
    }
  }
}
