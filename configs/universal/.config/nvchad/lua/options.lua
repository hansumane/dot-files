require "nvchad.options"

vim.opt.mouse = "nv"
vim.opt.scrolloff = 3
vim.g.c_syntax_for_h = true

vim.opt.keymap = "russian-jcukenwin"
vim.opt.iminsert = 0
vim.opt.imsearch = 0

vim.opt.showbreak = "↪"
vim.opt.listchars = {
  tab = "   ",
  trail = "␣",
  precedes = "⟨",
  extends = "⟩",
}
