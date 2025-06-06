return {
  'neovim/nvim-lspconfig',
  dependencies = { 'mason-org/mason.nvim', 'mason-org/mason-lspconfig.nvim' },
  event = 'VeryLazy',
  config = function()
    require('mason').setup()

    local wanted_servers = {
      clangd = false,
      yang_lsp = false,
    }
    for _, server in ipairs(require('mason-lspconfig').get_installed_servers()) do
      if wanted_servers[server] ~= nil then
        wanted_servers[server] = true
      end
      vim.lsp.enable(server)
    end
    for wanted_server, is_set in pairs(wanted_servers) do
      local server_cfg = vim.lsp.config[wanted_server]
      if server_cfg ~= nil and not is_set and vim.fn.executable(server_cfg.cmd[1]) then
        vim.lsp.enable(wanted_server)
      end
    end

    vim.diagnostic.config {
      virtual_text = true, -- virtual_lines = true,
      underline = false,
      signs = {
        text = {
          [ vim.diagnostic.severity.ERROR ] = 'x', -- '󰅚 ',
          [ vim.diagnostic.severity.WARN  ] = '!', -- '󰀪 ',
          [ vim.diagnostic.severity.INFO  ] = '*', -- '󰋽 ',
          [ vim.diagnostic.severity.HINT  ] = '?', -- '󰌶 ',
        }
      }
    }

    require('autocmds').now {
      name = 'LspAttach',
      data = {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(ev)
          local builtin = require('telescope.builtin')
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
          map('gd', builtin.lsp_definitions, 'Telescope Definitions')
          map('gr', builtin.lsp_references, 'Telescope References')
          map('<leader>la', vim.lsp.buf.code_action, 'Code Action')
          map('<leader>lr', vim.lsp.buf.rename, 'Rename All References')
          map('<leader>lx', ':Trouble diagnostics toggle focus=true filter.buf=0<CR>', 'Trouble Diagnostics')

          -- do not replace default tags with LSP definition
          vim.bo[ev.buf].tagfunc = nil
        end
      }
    }
  end
}
