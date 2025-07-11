_G.CreaGlobals = {
  vars = {},
  funcs = {}
}

local vars = CreaGlobals.vars
local funcs = CreaGlobals.funcs

vars.enable_cscope = true -- if false, then use default tags, `ctags`
vars.c_style = 'Kernel' -- 'Kernel' 'GNU'
vars.theme = 'kanagawa'
-- Maybe implement loading and saving the colorscheme from `Telescope colorscheme`:
-- https://github.com/nvim-telescope/telescope.nvim/issues/1961

vars.inlay_hints = true
vars.tabline = false

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
    tab = '-->',
    space = '⋅',
    trail = '␣',
    precedes = '⟨',
    extends = '⟩'
  }
}

vars.ibl_char = '▏' -- '▏' '▎' '┊' '╎' -- :h ibl.config.indent.char for more
vars.indentlines = {
  ibl = false,
  mini = false,
}
vars.ibl = {
  enabled = true,
  scope = { enabled = false },
  indent = { char = vars.ibl_char, tab_char = vars.ibl_char }
}

vars.diagnostics = {
  shown = {
    underline = false,
    update_in_insert = false,
    virtual_text = false,
    virtual_lines = true,
    -- virtual_text = { -- virtual_lines = true,
    --   current_line = true, -- show only when the cursor is on the line with diagnostic
    --   severity = { min = 'WARN', max = 'ERROR' }
    -- },
    -- signs = {
    --   priority = 9999,
    --   severity = { min = 'WARN', max = 'ERROR' },
    --   text = {
    --     [ vim.diagnostic.severity.ERROR ] = 'x', -- '󰅚 ',
    --     [ vim.diagnostic.severity.WARN  ] = '!', -- '󰀪 ',
    --     [ vim.diagnostic.severity.INFO  ] = '*', -- '󰋽 ',
    --     [ vim.diagnostic.severity.HINT  ] = '?', -- '󰌶 ',
    --   }
    -- }
  },
  hidden = {
    underline = false,
    update_in_insert = false,
    virtual_lines = false,
    virtual_text = {
      current_line = true
    }
  }
}

vars.ctrlk = {
  hide_inlay_hints = true,
  hide_diagnostics = true
}

funcs.update_cc = function(info, new_cc)
  if not new_cc then
    new_cc = vars.cc_dict[vim.o.colorcolumn] or vars.cd_init
  end

  vars.cc_dict.current = new_cc
  vim.o.textwidth = new_cc - 1
  if vim.o.number then
    vim.opt.colorcolumn = { new_cc }
  end

  if info then
    vim.print(info .. 'cc: ' .. (new_cc - 1))
  end
end

local off_indentlines = function()
  if vars.inlay_hints and vars.ctrlk.hide_inlay_hints then
    vim.lsp.inlay_hint.enable(true)
  end
  if vars.ctrlk.hide_diagnostics then
    vim.diagnostic.config(vars.diagnostics.shown)
  end
  if vars.indentlines.mini then
    vim.g.miniindentscope_disable = true
    vim.api.nvim_exec_autocmds("CursorMoved", {})
  end
  if vars.indentlines.ibl then
    vars.ibl.enabled = false
    require('ibl').setup(vars.ibl)
  end
end
local on_indentlines = function()
  if vars.indentlines.ibl then
    vars.ibl.enabled = true
    require('ibl').setup(vars.ibl)
  end
  if vars.indentlines.mini then
    vim.g.miniindentscope_disable = false
    vim.api.nvim_exec_autocmds("CursorMoved", {})
  end
  if vars.ctrlk.hide_diagnostics then
    vim.diagnostic.config(vars.diagnostics.hidden)
  end
  if vars.inlay_hints and vars.ctrlk.hide_inlay_hints then
    vim.lsp.inlay_hint.enable(false)
  end
end

funcs.switch_listchars = function()
  if not vim.opt.listchars:get().space then
    off_indentlines()
    vim.opt.listchars = vars.listchars.extended
  else
    vim.opt.listchars = vars.listchars.default
    on_indentlines()
  end
end

funcs.set_number = function(toggle)
  vim.opt.colorcolumn = toggle and { vars.cc_dict.current } or {}
  vim.o.textwidth = toggle and (vars.cc_dict.current - 1) or 0
  vim.o.number = toggle and true or false
  vim.o.cursorline = toggle and true or false
  vim.o.relativenumber = false -- toggle and true or false
  vim.o.list = toggle and true or false
end

funcs.set_indent = function(settings)
  local shift = settings.spaces or 4
  local tabst = settings.tabs or 8
  local stabs = settings.tabs or 8
  local noexpand = settings.noexpand

  vim.o.shiftwidth = shift
  vim.o.tabstop = tabst
  vim.o.softtabstop = stabs
  vim.o.expandtab = not noexpand and true or false
end

funcs.get_indent = function()
  local shift = vim.o.shiftwidth
  local tabst = vim.o.tabstop
  local expand = vim.o.expandtab

  local result = shift .. '/' .. tabst .. '-'
  if expand then
    result = result .. 'S'
  elseif shift ~= tabst then
    result = result .. 'M'
  else
    result = result .. 'T'
  end

  return result
end

funcs.restore_bg = function(store)
  local mode = store and 'w' or 'r'
  local new_bg = vim.o.background == 'dark' and 'light' or 'dark'
  local file_path = vim.fn.stdpath('state') .. '/bg.txt'
  local file, err = io.open(file_path, mode)

  if store then
    if not file then
      vim.notify('Cannot open bg file: ' .. err, vim.log.levels.ERROR)
    else
      file:write(new_bg)
      file:close()
    end
    vim.o.background = new_bg
    return new_bg
  else
    if not file then
      file, err = io.open(file_path, 'w')
      if file then file:write('dark'):close() end
      return 'dark'
    end
    new_bg = file:read('*line') == 'light' and 'light' or 'dark'
    file:close()
    return new_bg
  end
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
