local vars = CreaGlobals.vars
local funcs = CreaGlobals.funcs

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
    name = 'BufWinEnter',
    condition = true,
    data = {
      group = mk_load_view_group,
      callback = function(ev)
        if api.nvim_buf_get_name(ev.buf) ~= '' and vim.bo[ev.buf].buftype == '' then
          vim.cmd('silent! loadview')
        end
      end
    }
  },

  {
    name = 'BufWinLeave',
    condition = true,
    data = {
      group = mk_load_view_group,
      callback = function(ev)
        local file = api.nvim_buf_get_name(ev.buf)
        if file == '' or vim.bo[ev.buf].buftype ~= '' then return end

        local view = vim.fn.winsaveview()
        for _, move in ipairs({ 'zj', 'zk' }) do
          vim.cmd('silent! keepjumps normal! ' .. move)
          if vim.fn.foldlevel('.') > 0 then
            vim.fn.winrestview(view)
            vim.cmd('silent! mkview')
            return
          end
        end

        local viewpath = vim.o.viewdir .. '/' ..
                         vim.fn.fnamemodify(file, ":p:~"):gsub('/', '=+') .. '='
        if vim.fn.filereadable(viewpath) == 1 then
          vim.fn.delete(viewpath)
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
