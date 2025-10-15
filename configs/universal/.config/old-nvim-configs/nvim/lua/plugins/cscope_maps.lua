-- When opening project file from outside of project, plugin fails to properly build path
-- to cscope.out, for example, if the project is in ~/projects/project, and CWD is
-- ~/projects, and one opens ./project/main.c, the path to cscope.out will be
-- ../project/main.c, HOWEVER symbols from cscope.out will be loaded
--
-- At least with { cscope = { project_rooter = { enable = true } } } it correctly finds
-- cscope.out, when CWD is within the project (inside project root and any depth subfolder)

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

    require('autocmds').now {
      name = 'FileType',
      data = {
        pattern = { 'c', 'cpp' },
        callback = function(ev)
          local map = function(map, cmd, desc)
            require('mappings').now {
              mods = { 'n', 'v' },
              map = map,
              cmd = cmd,
              opts = {
                silent = true,
                noremap = true,
                buffer = ev.buf,
                desc = 'Cscope: ' .. desc
              }
            }
          end

          map('<C-c>g', function() cscope_wrap('CsPrompt g') end, 'Definition Prompt')
          map('<C-c><C-g>', function() cscope_wrap('Cscope find g') end, 'Definition')
          map('<C-c><C-r>', function() cscope_wrap('Cscope find c') end, 'References')
        end
      }
    }
  end
}
