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
--        ;
--        alternatively, adding cscope.out manually to db with `Cscope db add`
--        also fixes this issue, however, you will get symbols from all
--        manually added cscope.out files inside all of your projects
--        ;
--        also doing `Cscope reload` on `DirChanged` event works, but
--        it feels funny to me
--        (it still works when lazy)

return {
  'dhananjaylatkar/cscope_maps.nvim',
  ft = { 'c', 'cpp' },
  config = function()
    require('cscope_maps').setup {
      prefix = '<C-c>',
      cscope = {
        picker = 'telescope',
        project_rooter = { enable = true }
      }
    }

    require('autocmds').now {
      name = 'DirChanged',
      data = { callback = function() vim.cmd('Cscope reload') end }
    }

    local map = require('mappings').now
    map { mods = 'n', map = '<C-c><C-g>', cmd = ':Cscope find g<CR>', opts = { silent = true } }
    map { mods = 'n', map = '<C-c><C-r>', cmd = ':Cscope find c<CR>', opts = { silent = true } }
  end
}
