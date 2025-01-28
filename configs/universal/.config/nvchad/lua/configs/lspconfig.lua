local lspconfig = require "lspconfig"

local map = vim.keymap.set
local servers = { "pyright", "mesonlsp" }
local nvlsp = require "nvchad.configs.lspconfig"

local mya = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  map("n", "gr", '<cmd> lua require("telescope.builtin").lsp_references()<CR>')
  map("n", "<leader>cr", require "nvchad.lsp.renamer",
      { buffer = bufnr, desc = "LSP rename" })
end

local mya_clangd = function(client, bufnr)
  mya(client, bufnr)
  map("n", "<C-c><C-g>", "<cmd>Cscope find g<CR>")
  map("n", "<C-c><C-r>", "<cmd>Cscope find c<CR>")
end

-- from ~/.local/share/nvim/lazy/NvChad/lua/nvchad/configs/lspconfig.lua
local nv_defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  lspconfig.lua_ls.setup {
    on_attach = mya,
    capabilities = nvlsp.capabilities,
    on_init = nvlsp.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }
end

-- load defaults (lua_ls with nvim things)
nv_defaults()

-- load common settings for each server
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = mya,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- clangd lsp setup
lspconfig.clangd.setup {
  on_attach = mya_clangd,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
