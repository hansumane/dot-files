return {
  'altermo/ultimate-autopair.nvim', branch = 'v0.6',
  event = 'VeryLazy',
  config = function()
    require('ultimate-autopair').setup()
  end
}
