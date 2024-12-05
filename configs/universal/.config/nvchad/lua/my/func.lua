local cc_dict = require("my.ccdict")

function SetNumber(toggle)
  vim.opt.textwidth = toggle and (cc_dict.get("current") - 1) or 0
  vim.opt.colorcolumn = toggle and { cc_dict.get("current") } or {}
  vim.opt.number = toggle and true or false
  vim.opt.cursorline = toggle and true or false
  vim.opt.relativenumber = toggle and true or false
  vim.opt.list = toggle and true or false
end

function SetIndent(settings)
  local shift = settings.spaces or 4
  local tabst = settings.tabs or 8
  local stabs = settings.tabs or 8
  local noexpand = settings.noexpand

  vim.opt.shiftwidth = shift
  vim.opt.tabstop = tabst
  vim.opt.softtabstop = stabs
  vim.opt.expandtab = not noexpand and true or false
end

require("editorconfig").properties.max_line_length = function(_, val)
  local n = tonumber(val)
  if n then
    cc_dict.update_cc(nil, n + 1)
  else
    assert(val == "off", 'editorconfig: max_line_length: not number or "off"')
    cc_dict.update_cc(nil, cc_dict.get("init"))
  end
end
