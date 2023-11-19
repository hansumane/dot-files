local config = function ()
  local cmp = require'cmp'
  local luasnip = require'luasnip'
  local lsp_zero = require'lsp-zero'
  require'luasnip/loaders/from_vscode'.lazy_load()

  lsp_zero.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>lD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "<leader>li", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "<leader>lr", function() require'telescope.builtin'.lsp_references() end, opts)
  end)

  require'mason'.setup{}
  require'mason-lspconfig'.setup{
    ensure_installed = {
      'lua_ls',
      'clangd',
      'pyright',
      'rust_analyzer',
    },
    handlers = {
      lsp_zero.default_setup,
      lua_ls = function()
        local lua_opts = lsp_zero.nvim_lua_ls()
        require'lspconfig'.lua_ls.setup(lua_opts)
      end,
    },
  }

  cmp.setup{
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    sources = {
      {name = 'luasnip'},
      {name = 'buffer'},
      {name = 'path'},
      {name = 'nvim_lsp'},
      {name = 'nvim_lua'},
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert{
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable,
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<CR>"] = cmp.mapping.confirm{select = true},
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
  }
end

return {
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  {
    'VonHeikemen/lsp-zero.nvim',
    priority = 49,
    branch = 'v3.x',
    config = config,
  },
}
