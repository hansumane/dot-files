_G.CreaGlobals = {
  vars = {},
  funcs = {}
}

local vars = CreaGlobals.vars
local funcs = CreaGlobals.funcs

vars.enable_indentlines = true
vars.enable_cscope = true -- false, use default tags, `ctags`
vars.c_style = '' -- 'GNU'
vars.theme = 'nordic'

vars.cd_init = 81
vars.cc_dict = {
  current = vars.cd_init,
  ['81'] = 91,
  ['91'] = 101,
  ['101'] = 121,
  ['121'] = 81,
}

vars.listchars = {
  default = {
    tab = '   ',
    trail = '␣',
    precedes = '⟨',
    extends = '⟩'
  },
  extended = {
    tab = '',
    space = '⋅',
    trail = '␣',
    precedes = '⟨',
    extends = '⟩'
  }
}

vars.ibl_char = '▏' -- '▏' '┊'
vars.ibl = {
  enabled = true,
  indent = { char = vars.ibl_char, tab_char = vars.ibl_char },
  scope = { enabled = false }
}

funcs.update_cc = function(info, new_cc)
  if not new_cc then
    new_cc = vars.cc_dict[vim.opt.colorcolumn:get()[1]] or vars.cd_init
  end

  vars.cc_dict.current = new_cc
  vim.opt.textwidth = new_cc - 1
  if vim.opt.number:get() then
    vim.opt.colorcolumn = { new_cc }
  end

  if info then
    vim.print(info .. 'cc: ' .. (new_cc - 1))
  end
end

funcs.switch_listchars = function()
  if not vim.opt.listchars:get().space then
    if vars.enable_indentlines then
      vim.g.miniindentscope_disable = true
      vim.api.nvim_exec_autocmds("CursorMoved", {})
      vars.ibl.enabled = false
      require('ibl').setup(vars.ibl)
    end
    vim.opt.listchars = vars.listchars.extended
  else
    vim.opt.listchars = vars.listchars.default
    if vars.enable_indentlines then
      vars.ibl.enabled = true
      require('ibl').setup(vars.ibl)
      vim.g.miniindentscope_disable = false
      vim.api.nvim_exec_autocmds("CursorMoved", {})
    end
  end
end

funcs.set_number = function(toggle)
  vim.opt.textwidth = toggle and (vars.cc_dict.current - 1) or 0
  vim.opt.colorcolumn = toggle and { vars.cc_dict.current } or {}
  vim.opt.number = toggle and true or false
  vim.opt.cursorline = toggle and true or false
  vim.opt.relativenumber = false -- toggle and true or false
  vim.opt.list = toggle and true or false
end

funcs.set_indent = function(settings)
  local shift = settings.spaces or 4
  local tabst = settings.tabs or 8
  local stabs = settings.tabs or 8
  local noexpand = settings.noexpand

  vim.opt.shiftwidth = shift
  vim.opt.tabstop = tabst
  vim.opt.softtabstop = stabs
  vim.opt.expandtab = not noexpand and true or false
end

funcs.buf_kill = function(bufnr)
  local bo = vim.bo
  local fn = vim.fn
  local api = vim.api

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  local force = false
  local kill_command = 'bd'
  local bufname = api.nvim_buf_get_name(bufnr)

  local choice
  if bo[bufnr].modified then
    choice = fn.confirm(('Save "%s"?'):format(bufname), '&Yes\n&No\n&Cancel')
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
    choice = fn.confirm(('Close "%s"?'):format(bufname), '&Yes\n&No\n&Cancel')
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
    vim.cmd(('%s %d'):format(kill_command, bufnr))
  end
end
