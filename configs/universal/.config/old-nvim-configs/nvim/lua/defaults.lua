local vars = {
  cd_init = 81,
  enable_indentlines = true,
  enable_cscope = true, -- false - use ctags
  c_style = '', -- 'GNU'
  theme = 'nordic'
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
    vim.opt.swapfile = false
    vim.opt.showmode = false

    vim.opt.undofile = true
    vim.opt.undodir = vim.fn.stdpath('state') .. '/undodir'

    vim.opt.mouse = 'nv'
    vim.opt.scrolloff = 3
    vim.opt.laststatus = 2
    vim.opt.updatetime = 300
    vim.opt.timeoutlen = 1000
    vim.opt.ttimeoutlen = 50

    vim.opt.keymap = 'russian-jcukenwin'
    vim.opt.iminsert = 0
    vim.opt.imsearch = 0

    -- default guicursor value, but with Cursor/lCursor highlights
    vim.opt.guicursor = 'n-v-c-sm:block-Cursor/lCursor,' ..
                        'i-ci-ve:ver25-Cursor/lCursor,' ..
                        'r-cr-o:hor20-Cursor/lCursor,' ..
                        't:block-blinkon500-blinkoff500-TermCursor'

    vim.g.c_syntax_for_h = true

    -- Disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.clipboard:append { 'unnamedplus' }

    local com = vim.api.nvim_create_user_command
    local set_number = require('defaults').funcs.set_number
    local set_indent = require('defaults').funcs.set_indent
    com('SN',  function() set_number(true) end, {})
    com('USN', function() set_number(false) end, {})
    com('S2',  function() set_indent { spaces = 2 } end, {})
    com('S4',  function() set_indent { spaces = 4 } end, {})
    com('S8',  function() set_indent { spaces = 8 } end, {})
    com('T2',  function() set_indent { spaces = 2, tabs = 2, noexpand = true } end, {})
    com('T4',  function() set_indent { spaces = 4, tabs = 4, noexpand = true } end, {})
    com('T8',  function() set_indent { spaces = 8, tabs = 8, noexpand = true } end, {})
    com('M2',  function() set_indent { spaces = 2, tabs = 4, noexpand = true } end, {})
    com('M4',  function() set_indent { spaces = 4, tabs = 8, noexpand = true } end, {})
    com('MG',  function() set_indent { spaces = 2, tabs = 8, noexpand = true } end, {})
    set_number(true)
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
      local ibl = require 'plugins.ibl'
      if not vim.opt.listchars:get().space then
        if vars.enable_indentlines then
          vim.g.miniindentscope_disable = true
          vim.api.nvim_exec_autocmds("CursorMoved", {})
          ibl.get_vars().enabled = false
          ibl.setup()
        end
        vim.opt.listchars = {
          tab = '',
          space = '⋅',
          trail = '␣',
          precedes = '⟨',
          extends = '⟩'
        }
      else
        vim.opt.listchars = {
          tab = '   ',
          trail = '␣',
          precedes = '⟨',
          extends = '⟩'
        }
        if vars.enable_indentlines then
          ibl.get_vars().enabled = true
          ibl.setup()
          vim.g.miniindentscope_disable = false
          vim.api.nvim_exec_autocmds("CursorMoved", {})
        end
      end
    end,

    set_number = function(toggle)
      vim.opt.textwidth = toggle and (cc_dict.current - 1) or 0
      vim.opt.colorcolumn = toggle and { cc_dict.current } or {}
      vim.opt.number = toggle and true or false
      vim.opt.cursorline = toggle and true or false
      vim.opt.relativenumber = false -- toggle and true or false
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

    switch_input_language = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-6>', true, false, true), 'n', true)
      vim.defer_fn(require('lualine').refresh, 50)
    end,

    get_vars = function()
      return vars
    end,

    buf_kill = function(bufnr)
      local bo = vim.bo
      local fn = vim.fn
      local api = vim.api
      local fmt = string.format

      if bufnr == 0 or bufnr == nil then
        bufnr = api.nvim_get_current_buf()
      end

      local force = false
      local kill_command = 'bd'
      local bufname = api.nvim_buf_get_name(bufnr)

      local choice
      if bo[bufnr].modified then
        choice = fn.confirm(fmt('Save "%s"?', bufname), '&Yes\n&No\n&Cancel')
        if choice == 1 then
          api.nvim_buf_call(bufnr, function()
            vim.cmd('w')
          end)
        elseif choice == 2 then
          force = true
        else
          return
        end
      elseif api.nvim_get_option_value('buftype', { buf = bufnr }) == 'terminal' then
        choice = fn.confirm(fmt('Close "%s"?', bufname), '&Yes\n&No\n&Cancel')
        if choice == 1 then
          force = true
        else
          return
        end
      end

      if force then
        kill_command = kill_command .. '!'
      end

      local windows = vim.tbl_filter(function(win)
        return api.nvim_win_get_buf(win) == bufnr
      end, api.nvim_list_wins())

      local buffers = vim.tbl_filter(function(buf)
        return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
      end, api.nvim_list_bufs())

      if #buffers > 1 and #windows > 0 then
        for i, v in ipairs(buffers) do
          if v == bufnr then
            local prev_buf_idx = i == 1 and #buffers or (i - 1)
            local prev_buffer = buffers[prev_buf_idx]
            for _, win in ipairs(windows) do
              api.nvim_win_set_buf(win, prev_buffer)
            end
          end
        end
      end

      if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
        vim.cmd(fmt('%s %d', kill_command, bufnr))
      end
    end
  }
}
