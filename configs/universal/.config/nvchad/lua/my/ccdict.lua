CdInit = 81
CcDict = {
  init = CdInit,
  current = CdInit,
  ["81"] = 91,
  ["91"] = 101,
  ["101"] = 121,
  ["121"] = 81,
}

return {
  set = function(k, v) CcDict[k] = v end,
  get = function(k) return CcDict[k] end,
  update_cc = function(info, new_cc)
    if not new_cc then
      new_cc = CcDict[vim.opt.colorcolumn:get()[1]] or CcDict.init
    end

    CcDict.current = new_cc
    vim.opt.textwidth = new_cc - 1
    if vim.opt.number:get() then
      vim.opt.colorcolumn = { new_cc }
    end

    if info then
      vim.print(info .. "cc: " .. (new_cc - 1))
    end
  end
}
