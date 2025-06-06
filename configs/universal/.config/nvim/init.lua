require('defaults').setup()

local plugins = require 'plugins'
plugins.setup()

require('lazy').setup({ plugins.settings }, plugins.lazy_settings)

require('mappings').setup()
require('autocmds').setup()

-- TODO: replace with lualine or something
require('statusline').setup()
