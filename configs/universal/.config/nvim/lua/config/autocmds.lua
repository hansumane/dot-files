local globals = require('config.globals')
local vars = globals.vars
local funcs = globals.funcs

local api = vim.api
local au = api.nvim_create_autocmd
local aug = api.nvim_create_augroup

local mk_load_view_group = aug('MkLoadView', { clear = true })
local relative_number_group = aug('RelativeNumberVisualLine', { clear = true })

local autocmds = {
  {
    name = 'FileType',
    condition = function()
      return vars.c_style ~= ''
    end,
    data = {
      pattern = 'c,cpp,hc',
      callback = function()
        if vars.c_style == 'Kernel' then
          vim.bo.cinoptions = '(0'
        elseif vars.c_style == 'GNU' then
          vim.bo.cinoptions = '(0,f0,t0,:s,^-s,>2s,{s,Ws,n-s' -- sw=2 ts=8 noet
        end
      end
    }
  },

  {
    -- FIXME: It is not generally required, but due to bug in neo-tree or Telescope, when
    --        the Telescope search result is in the current buffer, and neo-tree is open,
    --        when `<Enter>` is pressed, neo-tree buffer goes to the right side of Neovim,
    --        and current buffer background color sets to the neo-tree buffer color
    -- NOTE: Also used to disable colorcolumn in `neo-tree`
    name = 'BufWinEnter',
    condition = true,
    data = {
      callback = function()
        if vim.bo.buftype == '' then -- ~= 'nofile'
          vim.wo.winhighlight = ''
        end
        if vim.bo.filetype == 'neo-tree' then
          vim.opt.colorcolumn = {}
        end
      end
    }
  },

  {
    name = 'ModeChanged',
    condition = true,
    data = {
      pattern = '*:[V\x16]*',
      group = relative_number_group,
      callback = function()
        vim.wo.relativenumber = vim.wo.number
      end
    }
  },

  {
    name = 'ModeChanged',
    condition = true,
    data = {
      pattern = '[V\x16]*:*',
      group = relative_number_group,
      callback = function()
        vim.wo.relativenumber = string.find(vim.fn.mode(), '^[V\22]') ~= nil
      end
    }
  },

  {
    name = 'ColorScheme',
    condition = true,
    data = {
      callback = function()
        local highlights = {
          ['@lsp.type.comment'] = {},
          ['@lsp.type.comment.c'] = { link = '@comment' },
          ['@lsp.type.comment.cpp'] = { link = '@comment' },
          ['MiniIndentscopeSymbolOff'] = { link = 'MiniIndentscopeSymbol' }
        }
        for group, highlight in pairs(highlights) do
          vim.api.nvim_set_hl(0, group, highlight)
        end
      end
    }
  }
}

for _, v in ipairs(autocmds) do
  if type(v.condition) == 'function' then
    if v.condition() then
      au(v.name, v.data)
    end
  elseif v.condition then
    au(v.name, v.data)
  end
end

funcs.au = function(autocmd)
  au(autocmd.name, autocmd.data)
end
