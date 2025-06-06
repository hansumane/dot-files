local autocmds = {
  {
    name = { 'BufNewFile', 'BufRead' },
    data = {
      pattern = '*.editorconfig',
      callback = function()
        vim.bo.filetype = 'editorconfig'
      end
    }
  },

  {
    name = 'BufWinEnter',
    data = {
      callback = function()
        -- HACK: fixes background change for normal buffers after NvimTree
        if vim.bo.buftype == '' then -- ~= 'nofile'
          vim.wo.winhighlight = ''
        end
      end
    }
  }
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
