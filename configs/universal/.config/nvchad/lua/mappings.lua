require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
map("n", "<S-h>", function() require("nvchad.tabufline").prev() end)
map("n", "<S-l>", function() require("nvchad.tabufline").next() end)
map("n", "<S-n>", function() require("nvchad.tabufline").move_buf(-1) end)
map("n", "<S-m>", function() require("nvchad.tabufline").move_buf( 1) end)
map("n", "<C-c><C-g>", "<cmd>Cscope find g<CR>")
map("n", "<C-c><C-r>", "<cmd>Cscope find c<CR>")
map("n", "<leader>k", ":sort<CR>", { desc = "Sort Lines" })
map("n", "<leader>j", "<cmd>noh<CR>", { desc = "No Highlight" })
