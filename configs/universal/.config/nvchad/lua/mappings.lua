require "nvchad.mappings"

local map = vim.keymap.set
local cc_dict = require "my.ccdict"

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

map("n", "<S-h>", function() require("nvchad.tabufline").prev() end)
map("n", "<S-l>", function() require("nvchad.tabufline").next() end)
map("n", "<S-n>", function() require("nvchad.tabufline").move_buf(-1) end)
map("n", "<S-m>", function() require("nvchad.tabufline").move_buf( 1) end)
map("n", "<leader>cc", function() require("nvchad.tabufline").close_buffer() end,
    { desc = "buffer close" })

map("n", "<leader>k", ":sort<CR>", { desc = "Sort Lines" })
map("n", "<leader>j", "<cmd>noh<CR>", { desc = "No Highlight" })

map("i", "<C-\\>", "<C-6>")
map("i", "<C-r>", "<C-v><C-i>")
map("n", "<leader>cx", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>",
    { desc = "buffer diagnostics" })

-- map("n", "gr", '<cmd> lua require("telescope.builtin").lsp_references()<CR>')
map("n", "<leader>fe",
    '<cmd>lua require("telescope.builtin").live_grep({' ..
    '  additional_args = function(opts) return { "--pcre2" } end })<CR>',
    { desc = "telescope find PCRE2" })
map("n", "<leader>ct", '<cmd>Trouble todo toggle focus=true<CR>',
    { desc = "buffer todo" })

map("n", "<C-j>", function() cc_dict.update_cc("") end)
map("n", "<C-k>", function()
  if not vim.opt.listchars:get().space then
    -- TODO: require("indent_blankline.commands").disable(true)
    vim.opt.listchars = {
      tab = "-->",
      space = "⋅",
      trail = "␣",
      precedes = "⟨",
      extends = "⟩",
    }
    vim.print("Indent Guidelines: off")
  else
    vim.opt.listchars = {
      tab = "   ",
      trail = "␣",
      precedes = "⟨",
      extends = "⟩",
    }
    -- TODO: require("indent_blankline.commands").enable(true)
    vim.print("Indent Guidelines: on")
  end
end)
