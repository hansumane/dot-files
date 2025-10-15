return {
  'gpanders/editorconfig.nvim',
  config = function()
    local update_cc = require('defaults').funcs.update_cc
    local cc_dict_init = require('defaults').funcs.get_vars().cd_init

    require('editorconfig').properties.max_line_length = function(_, val)
      local n = tonumber(val)
      if n then
        update_cc(nil, n + 1)
      else
        assert(val == 'off', 'editorconfig: max_line_length: not number or "off"')
        update_cc(nil, cc_dict_init)
      end
    end
  end
}
