-- FIXME: when opening project file from outside of project,
--        plugin fails to properly build path to cscope.out,
--        for example, if the project is in ~/projects/project,
--        and CWD is ~/projects, and one opens ./project/main.c,
--        the path to cscope.out will be ../project/main.c,
--        HOWEVER symbols from cscope.out will be loaded
--        ;
--        at least with { cscope = { project_rooter = { enable = true } } }
--        it correctly finds cscope.out, when CWD is within the project
--        (inside project root and any depth subfolder)

local prev_cwd = ''
local cscope_wrap = function(cmd)
  local cur_cwd = vim.fn.getcwd()
  if cur_cwd ~= prev_cwd then
    prev_cwd = cur_cwd
    vim.cmd('Cscope reload')
  end
  vim.cmd(cmd)
end

return {
  'dhananjaylatkar/cscope_maps.nvim',
  ft = { 'c', 'cpp' },
  config = function()
    require('cscope_maps').setup {
      prefix = '', disable_maps = true,
      cscope = { picker = 'telescope' }
    }

    local map = require('mappings').now
    map { mods = { 'n', 'v' }, map = '<C-c>g', opts = { silent = true },
          cmd = function() cscope_wrap('CsPrompt g') end }
    map { mods = { 'n', 'v' }, map = '<C-c><C-g>', opts = { silent = true },
          cmd = function() cscope_wrap('Cscope find g') end }
    map { mods = { 'n', 'v' }, map = '<C-c><C-r>', opts = { silent = true },
          cmd = function() cscope_wrap('Cscope find c') end }
  end
}
