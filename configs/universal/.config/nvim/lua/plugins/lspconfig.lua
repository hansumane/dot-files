return {
  'neovim/nvim-lspconfig',
  dependencies = { 'mason-org/mason.nvim', 'mason-org/mason-lspconfig.nvim' },
  event = 'VeryLazy',
  config = function()
    require('mason').setup()

    local wanted_servers = {
      clangd = false,
    }
    for _, server in ipairs(require('mason-lspconfig').get_installed_servers()) do
      if wanted_servers[server] ~= nil then
        wanted_servers[server] = true
      end
      vim.lsp.enable(server)
    end
    for wanted_server, is_set in pairs(wanted_servers) do
      if not is_set and vim.fn.executable(wanted_server) then
        vim.lsp.enable(wanted_server)
      end
    end

    vim.diagnostic.config {
      virtual_text = true, -- virtual_lines = true,
      underline = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 '
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          [vim.diagnostic.severity.WARN] = 'WarningMsg'
        }
      }
    }

    require('autocmds').now {
      name = 'LspAttach',
      data = {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(ev)
          local map = function(map, cmd, desc)
            require('mappings').now {
              mods = 'n',
              map = map,
              cmd = cmd,
              opts = {
                silent = true,
                buffer = ev.buf,
                desc = 'LSP: ' .. desc
              }
            }
          end

          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gd', require('telescope.builtin').lsp_definitions, 'Telescope Definitions')
          map('gr', require('telescope.builtin').lsp_references, 'Telescope References')
          map('<leader>la', vim.lsp.buf.code_action, 'Code Action')
          map('<leader>lr', vim.lsp.buf.rename, 'Rename All References')
          map('<leader>lx', ':Trouble diagnostics toggle focus=true filter.buf=0<CR>', 'Trouble Diagnostics')
        end
      }
    }
  end
}
