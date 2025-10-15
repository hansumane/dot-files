return {
  'altermo/ultimate-autopair.nvim', branch = 'v0.6',
  event = 'VeryLazy',
  opts = {},
}

--[[
return {
  'windwp/nvim-autopairs',
  event = 'VeryLazy',
  opts = { check_ts = true }
}
--]]

--[[
return {
  'echasnovski/mini.pairs', version = '*',
  event = 'VeryLazy',
  config = true
}
--]]

--[[
return {
  'cohama/lexima.vim',
  event = 'VeryLazy',
  config = function()
    vim.g.lexima_enable_basic_rules = 1
    vim.g.lexima_enable_newline_rules = 1
    vim.g.lexima_enable_endwise_rules = 1
  end
}
--]]
