local cd_init = 81
local cc_dict = {
  init = cd_init,
  current = cd_init,
  ["81"] = 91,
  ["91"] = 101,
  ["101"] = 121,
  ["121"] = 81,
}

return {
  set = function(k, v) cc_dict[k] = v end,
  get = function(k) return cc_dict[k] end,
  update_cc = function(info, new_cc)
    if not new_cc then
      new_cc = cc_dict[vim.opt.colorcolumn:get()[1]] or cc_dict.init
    end

    cc_dict.current = new_cc
    vim.opt.textwidth = new_cc - 1
    if vim.opt.number:get() then
      vim.opt.colorcolumn = { new_cc }
    end

    if info then
      vim.print(info .. "cc: " .. (new_cc - 1))
    end
  end
}
