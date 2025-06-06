require('defaults').setup()
require('mappings').setup()
require('autocmds').setup()

local plugins = require 'plugins'
plugins.setup()

require('lazy').setup({ plugins.settings }, plugins.lazy_settings)
