-- LunarVim (lvim) config

vim.opt.mouse = 'nv'
vim.opt.scrolloff = 3
vim.g.c_syntax_for_h = true
vim.cmd[[set iskeyword-=_]]

vim.opt.keymap = 'russian-jcukenwin'
vim.opt.iminsert = 0
vim.opt.imsearch = 0

lvim.builtin.which_key.mappings['w'] = {}
lvim.builtin.which_key.mappings['h'] = {}
lvim.builtin.terminal.open_mapping = '<C-t>'

lvim.keys.insert_mode['<C-\\>'] = '<C-6>'
lvim.keys.insert_mode['<C-k>'] = '<C-v><C-i>'
lvim.keys.normal_mode['<S-h>'] = '<cmd>BufferLineCyclePrev<CR>'
lvim.keys.normal_mode['<S-l>'] = '<cmd>BufferLineCycleNext<CR>'
lvim.keys.normal_mode['<S-n>'] = '<cmd>BufferLineMovePrev<CR>'
lvim.keys.normal_mode['<S-m>'] = '<cmd>BufferLineMoveNext<CR>'

lvim.builtin.which_key.mappings.j = {'<cmd>noh<CR>', 'No Highlight'}
lvim.builtin.which_key.vmappings.k = {':sort<CR>', 'Sort Lines'}
lvim.builtin.which_key.mappings.lt = {'<cmd>TodoTelescope<CR>', 'TODOs'}

lvim.lsp.buffer_mappings.normal_mode.gr = {
  [[<cmd>lua require'telescope.builtin'.lsp_references()<CR>]],
  'References'
}

function SetNumber(toggle)
  vim.opt.colorcolumn = toggle and {91, 141} or {}
  vim.opt.number = toggle and true or false
  vim.opt.cursorline = toggle and true or false
  vim.opt.relativenumber = toggle and true or false
end

function SetIndent(settings)
  local shift = settings.spaces or 4
  local tabst = settings.tabs or 8
  local stabs = settings.tabs or 8
  local noexpand = settings.noexpand

  vim.opt.shiftwidth = shift
  vim.opt.tabstop = tabst
  vim.opt.softtabstop = stabs

  if noexpand then
    vim.opt.expandtab = false
  else
    vim.opt.expandtab = true
  end
end

lvim.format_on_save.enabled = false
lvim.builtin.nvimtree.setup.view.adaptive_size = true

lvim.builtin.telescope.defaults.initial_mode = 'normal'
lvim.builtin.telescope.defaults.layout_strategy = 'horizontal'
lvim.builtin.telescope.defaults.layout_config.width = 0.9
lvim.builtin.telescope.defaults.layout_config.height = 0.9
lvim.builtin.telescope.defaults.layout_config.preview_width = 0.55
lvim.builtin.telescope.defaults.layout_config.prompt_position = 'top'

lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.sync_install = false
lvim.builtin.treesitter.highlight.enable = true

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {'pyright'})
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= 'jedi_language_server'
end, lvim.lsp.automatic_configuration.skipped_servers)

lvim.lsp.automatic_servers_installation = false
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.installer.setup.ensure_installed = {
  'lua_ls', 'clangd', 'rust_analyzer', 'jedi_language_server'
}

local components = require'lvim.core.lualine.components'
lvim.builtin.lualine.sections.lualine_a = {'mode'}
lvim.builtin.lualine.sections.lualine_x = {
  components.lsp,
  components.filetype,
  function ()
    if vim.opt.iminsert:get() ~= 0 then
      return 'RU'
    else
      return 'EN'
    end
  end
}
lvim.builtin.lualine.sections.lualine_y = {
  function ()
    local shift = vim.opt.shiftwidth:get()
    local tabst = vim.opt.tabstop:get()
    local expand = vim.opt.expandtab:get()
    local result = shift .. '/' .. tabst .. '-'
    if expand then
      result = result .. 'S'
    elseif shift ~= tabst then
      result = result .. 'M'
    else
      result = result .. 'T'
    end
    return result
  end
}

lvim.autocommands = {
  {
    'VimEnter', {
      callback = function ()
        vim.cmd [[
        command! SN :lua SetNumber(true)
        command! USN :lua SetNumber(false)
        command! S2 :lua SetIndent{spaces = 2}
        command! S4 :lua SetIndent{spaces = 4}
        command! S8 :lua SetIndent{spaces = 8}
        command! T2 :lua SetIndent{spaces = 2, tabs = 2, noexpand = true}
        command! T4 :lua SetIndent{spaces = 4, tabs = 4, noexpand = true}
        command! T8 :lua SetIndent{spaces = 8, tabs = 8, noexpand = true}
        command! M2 :lua SetIndent{spaces = 2, tabs = 4, noexpand = true}
        command! M4 :lua SetIndent{spaces = 4, tabs = 8, noexpand = true}
        command! MG :lua SetIndent{spaces = 2, tabs = 8, noexpand = true}
        highlight ColorColumn guibg='#292e42'
        ]]
        SetNumber(true)
      end
    },
    'QuitPre', {
      callback = function ()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()

        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match'NvimTree_' ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= '' then
            table.insert(floating_wins, w)
          end
        end

        if #wins - #floating_wins - #tree_wins == 1 then
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end
    }
  }
}

lvim.plugins = {
--[[
  {
    'catppuccin/nvim',
    name = "catppuccin",
    priority = 1500,
    config = function ()
      vim.opt.background = 'dark'
      require'catppuccin'.setup{flavour = 'mocha'}
      lvim.colorscheme = 'catppuccin'
    end
  },
  {
    'sainnhe/everforest',
    priority = 1500,
    config = function ()
      vim.opt.background = 'dark'
      vim.g.everforest_background = 'hard'
      vim.g.everforest_better_performance = 1
      lvim.colorscheme = 'everforest'
    end
  },
  {
    'mcchrish/zenbones.nvim',
    dependencies = {'rktjmp/lush.nvim'},
    config = function ()
      vim.opt.background = 'dark'
      lvim.colorscheme = 'zenbones'
    end
  },
--]]
  {
    'folke/todo-comments.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = {}
  }
}

local lsp_options = {
  settings = {
    ['rust-analyzer'] = {
      lens = {
        enable = false
      },
      checkOnSave = {
        command = 'clippy'
      },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true
        }
      }
    },
    Lua = {
      runtime = {
        version = 'Lua 5.4',
      },
      --[[
      workspace = {
        library = {
          ['~/virtual/definitions'] = true,
          ['~/virtual/vm_mount/usr/share/lua/5.4'] = true,
        }
      }
      --]]
    }
  }
}

require'lvim.lsp.manager'.setup('rust_analyzer', lsp_options)
require'lvim.lsp.manager'.setup('lua_ls', lsp_options)
lvim.builtin.treesitter.ignore_install = {'make'}

if vim.fn.has('nightly') then
  local orig_notify = vim.notify
  local filter_notify = function (text, level, opts)
    if (type(text) == 'string' and
        (string.find(text, 'vim.lsp.util.parse_snippet is deprecated :help deprecated') or
         string.find(text, "in function 'parse_snippet'"))) then
      return
    end
    orig_notify(text, level, opts)
  end
  vim.notify = filter_notify
end
