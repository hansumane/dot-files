return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim'
  },
  event = 'VeryLazy',
  config = function()
    local globals = require('config.globals')
    local vars = globals.vars
    local funcs = globals.funcs

    require('mason').setup()

    local rust_analyzer_lspconfig_on_attach = vim.lsp.config['rust_analyzer'].on_attach

    local wanted_servers = {
      -- sourcekit = { enabled = false, config = nil },
      yang_lsp = { enabled = false, config = nil },
      pyright = { enabled = false, config = nil },
      clangd = { enabled = false, config = nil },
      zls = { enabled = false, config = nil },
      lua_ls = {
        enabled = false,
        config = {
          settings = {
            Lua = {
              -- <.luarc.json>
              runtime = { version = 'Lua 5.4' },
              workspace = {
                library = {
                  '/usr/share/lua/5.4'
                }
              }
              -- </.luarc.json>
            }
          }
        }
      },
      rust_analyzer = {
        enabled = false,
        config = {
          settings = {
            ['rust-analyzer'] = {
              check = { command = 'clippy' },
              inlayHints = { typeHints = { enable = true } },
              diagnostics = {
                experimental = { enable = true },
                enable = true
              }
            }
          },
          on_attach = function(client, bufnr)
            -- Disable LSP syntax highlighting:
            -- client.server_capabilities.semanticTokensProvider = nil
            if rust_analyzer_lspconfig_on_attach then
              rust_analyzer_lspconfig_on_attach(client, bufnr)
            end
          end
        }
      }
    }

    for _, name in ipairs(require('mason-lspconfig').get_installed_servers()) do
      local server = wanted_servers[name]
      if server ~= nil then
        server.enabled = true
        if server.config ~= nil then
          vim.lsp.config(name, server.config)
        end
      end
      vim.lsp.enable(name)
    end

    for name, server in pairs(wanted_servers) do
      local cfg = vim.lsp.config[name]
      if not server.enabled and cfg ~= nil and vim.fn.executable(cfg.cmd[1]) == 1 then
        if server.config ~= nil then
          vim.lsp.config(name, server.config)
        end
        vim.lsp.enable(name)
      end
    end

    for wanted_server, is_set in pairs(wanted_servers) do
      local cfg = vim.lsp.config[wanted_server]
      if cfg ~= nil and not is_set and vim.fn.executable(cfg.cmd[1]) == 1 then
        vim.lsp.enable(wanted_server)
      end
    end

    vim.lsp.log.set_level(vim.log.levels.ERROR)

    if not vars.ctrlk.hide_diagnostics then
      vim.diagnostic.config(vars.diagnostics.shown)
    else
      vim.diagnostic.config(vars.diagnostics.hidden)
    end

    if vars.inlay_hints then
      if not vars.ctrlk.hide_inlay_hints then
        vim.lsp.inlay_hint.enable(true)
      else
        vim.lsp.inlay_hint.enable(false)
      end
    else
      vim.lsp.inlay_hint.enable(false)
    end

    funcs.au {
      name = 'LspAttach',
      data = {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(ev)
          local builtin = require('telescope.builtin')
          local map = function(mods, map, cmd, desc)
            funcs.map {
              mods = mods, map = map, cmd = cmd,
              opts = {
                silent = true,
                -- noremap = true,
                buffer = ev.buf,
                desc = 'LSP: ' .. desc
              }
            }
          end

          map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
          map('i', '<C-h>', vim.lsp.buf.signature_help, 'Signature Help')
          map('n', 'gd', builtin.lsp_definitions, 'Telescope Definitions')
          map('n', 'gr', builtin.lsp_references, 'Telescope References')
          map('n', '<leader>la', vim.lsp.buf.code_action, 'Code Action')
          map('n', '<leader>lr', vim.lsp.buf.rename, 'Rename All References')

          -- do not replace default tags with LSP definition
          vim.bo[ev.buf].tagfunc = nil
        end
      }
    }
  end
}
