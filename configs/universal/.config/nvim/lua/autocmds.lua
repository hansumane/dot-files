local autocmds = {
  {
    name = 'VimEnter',
    data = {
      callback = function()
        vim.fn.setreg('/', '')
      end
    },
    condition = true
  },

  {
    name = 'FileType',
    data = {
      pattern = 'c,cpp',
      callback = function()
        vim.bo.cindent = true
        vim.bo.cinoptions = '(0,f0,t0,:s,^-s,>2s,{s,Ws,n-s' -- sw=2 ts=8 noet
      end
    },
    condition = function()
      return require('defaults').funcs.get_vars().c_style == 'GNU'
    end
  },

  {
    name = { 'BufNewFile', 'BufRead' },
    data = {
      pattern = '*.editorconfig',
      callback = function()
        vim.bo.filetype = 'editorconfig'
      end
    },
    condition = true
  },

  {
    -- It is not generally required for neo-tree, but required for NvimTree. Also, due to
    -- a bug in neo-tree or Telescope, when the Telescope search result is in the current
    -- buffer, and neo-tree is open, when `<Enter>` is pressed, neo-tree buffer goes to
    -- the right side of Neovim, and current buffer background color sets to the neo-tree
    -- buffer color
    name = 'BufWinEnter',
    data = {
      callback = function()
        if vim.bo.buftype == '' then -- ~= 'nofile'
          vim.wo.winhighlight = ''
        end
      end
    },
    condition = true
  }
}

return {
  setup = function()
    for _, v in ipairs(autocmds) do
      if type(v.condition) == 'function' and v.condition() or v.condition then
        vim.api.nvim_create_autocmd(v.name, v.data)
      end
    end
  end,

  now = function(autocmd)
    vim.api.nvim_create_autocmd(autocmd.name, autocmd.data)
  end
}
