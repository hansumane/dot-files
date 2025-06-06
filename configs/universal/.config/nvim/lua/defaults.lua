local vars = {
  cd_init = 81,
  enable_indentlines = true
}

local cc_dict = {
  init = vars.cd_init,
  current = vars.cd_init,
  ['81'] = 91,
  ['91'] = 101,
  ['101'] = 121,
  ['121'] = 81,
}

return {
  setup = function()
    vim.opt.list = true
    ---@diagnostic disable-next-line
    vim.opt.listchars = {
      tab = '   ',
      trail = '␣',
      precedes = '⟨',
      extends = '⟩'
    }

    vim.opt.wrap = false
    vim.opt.hidden = true
    vim.opt.signcolumn = 'yes'
    vim.opt.termguicolors = true

    vim.opt.hlsearch = true
    vim.opt.incsearch = true
    vim.opt.showmatch = true
    vim.opt.ignorecase = true
    vim.opt.smartcase = true

    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.undofile = false
    vim.opt.swapfile = false
    vim.opt.showmode = false

    vim.opt.mouse = 'nv'
    vim.opt.scrolloff = 3
    vim.opt.laststatus = 2
    vim.opt.updatetime = 300
    vim.opt.timeoutlen = 1000
    vim.opt.ttimeoutlen = 50

    vim.opt.keymap = 'russian-jcukenwin'
    vim.opt.iminsert = 0
    vim.opt.imsearch = 0

    vim.g.c_syntax_for_h = true
    vim.g.c_style = ''  -- 'GNU'

    vim.opt.clipboard:append { 'unnamedplus' }

    local com = vim.api.nvim_create_user_command
    com('SN',  function() require('defaults').funcs.set_number(true) end, { })
    com('USN', function() require('defaults').funcs.set_number(false) end, { })
    com('S2',  function() require('defaults').funcs.set_indent { spaces = 2 } end, { })
    com('S4',  function() require('defaults').funcs.set_indent { spaces = 4 } end, { })
    com('S8',  function() require('defaults').funcs.set_indent { spaces = 8 } end, { })
    com('T2',  function() require('defaults').funcs.set_indent { spaces = 2, tabs = 2, noexpand = true } end, { })
    com('T4',  function() require('defaults').funcs.set_indent { spaces = 4, tabs = 4, noexpand = true } end, { })
    com('T8',  function() require('defaults').funcs.set_indent { spaces = 8, tabs = 8, noexpand = true } end, { })
    com('M2',  function() require('defaults').funcs.set_indent { spaces = 2, tabs = 4, noexpand = true } end, { })
    com('M4',  function() require('defaults').funcs.set_indent { spaces = 4, tabs = 8, noexpand = true } end, { })
    com('MG',  function() require('defaults').funcs.set_indent { spaces = 2, tabs = 8, noexpand = true } end, { })

    require('defaults').funcs.set_number(true)
  end,

  funcs = {
    update_cc = function(info, new_cc)
      if not new_cc then
        new_cc = cc_dict[vim.opt.colorcolumn:get()[1]] or cc_dict.init
      end

      cc_dict.current = new_cc
      vim.opt.textwidth = new_cc - 1
      if vim.opt.number:get() then
        vim.opt.colorcolumn = true and { new_cc } or {}
      end

      if info then
        vim.print(info .. 'cc: ' .. (new_cc - 1))
      end
    end,

    switch_listchars = function()
      if not vim.opt.listchars:get().space then
        if vars.enable_indentlines then
          require("indent_blankline.commands").disable(true)
        end
        ---@diagnostic disable-next-line
        vim.opt.listchars = {
          tab = "-->",
          space = "⋅",
          trail = "␣",
          precedes = "⟨",
          extends = "⟩"
        }
      else
        ---@diagnostic disable-next-line
        vim.opt.listchars = {
          tab = "   ",
          trail = "␣",
          precedes = "⟨",
          extends = "⟩"
        }
        if vars.enable_indentlines then
          require("indent_blankline.commands").enable(true)
        end
      end
    end,

    set_number = function(toggle)
      vim.opt.textwidth = toggle and (cc_dict.current - 1) or 0
      vim.opt.colorcolumn = toggle and { cc_dict.current } or {}
      vim.opt.number = toggle and true or false
      vim.opt.cursorline = toggle and true or false
      vim.opt.relativenumber = toggle and true or false
      vim.opt.list = toggle and true or false
    end,

    set_indent = function(settings)
      local shift = settings.spaces or 4
      local tabst = settings.tabs or 8
      local stabs = settings.tabs or 8
      local noexpand = settings.noexpand

      vim.opt.shiftwidth = shift
      vim.opt.tabstop = tabst
      vim.opt.softtabstop = stabs
      vim.opt.expandtab = not noexpand and true or false
    end,

    get_vars = function()
      return vars
    end
  }
}
