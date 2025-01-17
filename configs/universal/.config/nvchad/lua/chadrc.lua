-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "flexoki",
  -- hl_override = {
  --   Comment = { italic = true },
  --   ["@comment"] = { italic = true },
  -- },
}

M.ui = {
  statusline = {
    order = { "mode", "file", "git",
              "%=", "vlines", "lsp_msg", "%=",
              "lsp", "cwd", "klang" },
    modules = {
      vlines = function()
        local isvm = vim.fn.mode():find("[vV]")
        if not isvm then return "" end

        local starts = vim.fn.line("v")
        local ends = vim.fn.line(".")
        local lines = starts <= ends and ends - starts + 1 or starts - ends + 1

        if lines <= 1 then
          return " " .. vim.fn.wordcount().visual_chars .. "C "
        else
          return " " .. lines .. "L "
        end
      end,
      klang = function()
        if vim.opt.iminsert:get() ~= 0 then
          return "RU "
        else
          return ""
        end
      end
    }
  }
}

return M
