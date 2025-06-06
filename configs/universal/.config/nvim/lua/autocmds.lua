local autocmds = {
  -- {
  --   name = { 'BufNewFile', 'BufRead' },
  --   data = {
  --     pattern = '*.its',
  --     callback = function()
  --       vim.opt.filetype = 'dts'
  --     end
  --   }
  -- }
}

return {
  setup = function()
    for _, v in ipairs(autocmds) do
      vim.api.nvim_create_autocmd(v.name, v.data)
    end
  end,

  add = function(autocmd)
    table.insert(autocmds, autocmd)
  end
}
