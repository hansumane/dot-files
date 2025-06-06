local autocmds = {
  {
    name = 'VimEnter',
    data = {
      callback = function()
        vim.fn.setreg('/', '')
      end
    }
  },

  {
    name = 'FileType',
    data = {
      pattern = 'c,cpp',
      callback = function()
        if vim.g.c_style == 'GNU' then
          vim.bo.cindent = true
          vim.bo.cinoptions = '(0,f0,t0,:s,^-s,>2s,{s,Ws,n-s' -- sw=2 ts=8 noet
        end
      end
    }
  },

  {
    name = { 'BufNewFile', 'BufRead' },
    data = {
      pattern = '*.editorconfig',
      callback = function()
        vim.bo.filetype = 'editorconfig'
      end
    }
  }

  --[[
  {
    name = 'BufWinEnter',
    data = {
      callback = function()
        if vim.bo.buftype == '' then -- ~= 'nofile'
          vim.wo.winhighlight = ''
        end
      end
    }
  }
  --]]
}

return {
  setup = function()
    for _, v in ipairs(autocmds) do
      vim.api.nvim_create_autocmd(v.name, v.data)
    end
  end,

  now = function(autocmd)
    vim.api.nvim_create_autocmd(autocmd.name, autocmd.data)
  end
}
