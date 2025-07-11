local vars = CreaGlobals.vars
local funcs = CreaGlobals.funcs

local autocmds = {
  {
    name = 'FileType',
    condition = function()
      return vars.c_style == 'GNU'
    end,
    data = {
      pattern = 'c,cpp',
      callback = function()
        vim.bo.cindent = true
        vim.bo.cinoptions = '(0,f0,t0,:s,^-s,>2s,{s,Ws,n-s' -- sw=2 ts=8 noet
      end
    }
  },

  {
    -- FIXME: It is not generally required, but due to bug in neo-tree or Telescope, when
    --        the Telescope search result is in the current buffer, and neo-tree is open,
    --        when `<Enter>` is pressed, neo-tree buffer goes to the right side of Neovim,
    --        and current buffer background color sets to the neo-tree buffer color
    name = 'BufWinEnter',
    condition = true,
    data = {
      callback = function()
        if vim.bo.buftype == '' then -- ~= 'nofile'
          vim.wo.winhighlight = ''
        end
      end
    }
  },

  {
    name = 'ModeChanged',
    condition = true,
    data = {
      pattern = '*:[V\x16]*',
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
      callback = function()
        vim.wo.relativenumber = string.find(vim.fn.mode(), '^[V\22]') ~= nil
      end
    }
  }
}

for _, v in ipairs(autocmds) do
  if type(v.condition) == 'function' and v.condition() or v.condition then
    vim.api.nvim_create_autocmd(v.name, v.data)
  end
end

funcs.au = function(autocmd)
  vim.api.nvim_create_autocmd(autocmd.name, autocmd.data)
end
