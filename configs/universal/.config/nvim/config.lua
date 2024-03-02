-- LunarVim (lvim) config

local use_indent_lines = false

vim.opt.mouse = 'nv'
vim.opt.scrolloff = 3
vim.g.c_syntax_for_h = true
vim.cmd[[set iskeyword-=_]]
if not use_indent_lines then
  vim.opt.showbreak = '↪'
  vim.opt.listchars = {
    -- eol = '↲',
    space = '⋅',
    tab = '│ →',
    trail = '␣',
    precedes = '⟨',
    extends = '⟩',
  }
end

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

local cc_dict = {
  init = 91,
  ['81'] = 91,
  ['91'] = 101,
  ['101'] = 121,
  ['121'] = 81,
}

local cc_fix = function ()
  if lvim.colorscheme == 'lunar' or lvim.colorscheme == 'tokyonight' then
    vim.cmd[[highlight ColorColumn guibg='#292e42']]
  end
end

lvim.keys.normal_mode['<C-j>'] = function ()
  if vim.opt.number:get() then
    local cc = vim.opt.colorcolumn:get()[1]
    vim.opt.colorcolumn = {cc_dict[cc]}
    print(cc_dict[cc] - 1)
    cc_fix()
  end
end

function SetNumber(toggle)
  vim.opt.colorcolumn = toggle and {cc_dict.init} or {}
  vim.opt.number = toggle and true or false
  vim.opt.cursorline = toggle and true or false
  vim.opt.relativenumber = toggle and true or false
  if not use_indent_lines then vim.opt.list = toggle and true or false end
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

if not use_indent_lines then
  lvim.builtin.indentlines.options.use_treesitter = false
  lvim.builtin.indentlines.active = false
else
  lvim.builtin.indentlines.options.use_treesitter = true
  lvim.builtin.indentlines.active = true
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

vim.lsp.set_log_level'off'
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {'pyright'})
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= 'jedi_language_server'
-- end, lvim.lsp.automatic_configuration.skipped_servers)

--lvim.builtin.treesitter.auto_install = false
lvim.lsp.automatic_servers_installation = false
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.installer.setup.ensure_installed = {
  'lua_ls', 'clangd', 'rust_analyzer', 'pyright', 'jdtls'
} --+ flake8, black
lvim.builtin.treesitter.ensure_installed = {
  'bash',
  'c', 'cpp', 'cmake', 'meson',
  'java', 'lua', 'python', 'rust',
  'vim', 'vimdoc',
  'dockerfile', 'json', 'toml', 'xml', 'yaml', 'ssh_config',
  'comment', 'markdown', 'markdown_inline', 'query', 'regex',
  'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore'
}
lvim.builtin.treesitter.ignore_install = {
  'make'
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
        ]]
        cc_fix()
        SetNumber(true)
      end
    },
  },
  {
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
    name = 'catppuccin',
    priority = 1500,
    lazy = false,
    config = function ()
      vim.opt.background = 'dark'
      require'catppuccin'.setup{flavour = 'mocha'}
      lvim.colorscheme = 'catppuccin'
    end
  },
  {
    'sainnhe/everforest',
    priority = 1500,
    lazy = false,
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
  {
    'sainnhe/gruvbox-material',
    priority = 1500,
    lazy = false,
    config = function ()
      vim.opt.background = 'dark'
      vim.g.gruvbox_material_background = 'hard' -- medium (default), soft
      vim.g.gruvbox_material_better_performance = 1
      lvim.colorscheme = 'gruvbox-material'
    end
  },
--]]
  {
    'folke/tokyonight.nvim',
    priority = 1500,
    lazy = false,
    config = function()
      vim.opt.background = 'dark'
      require'tokyonight'.setup{
        style = 'night',
        light_style = 'day',          -- from lightest to darkest:
        day_brightness = 0.25,        --  1. storm (default)
        terminal_colors = true,       --  2. moon
        comments = { italic = true }, --  3. night (lunarvim)
        keywords = { italic = true },
      }
      lvim.colorscheme = 'tokyonight'
    end
  },
  {
    'folke/todo-comments.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = {}
  }
}

require'lvim.lsp.manager'.setup('pyright', {
  settings = {
    python = {
      pythonPath = 'python3'
    }
  }
})
require'lvim.lsp.manager'.setup('jdtls', {
  cmd = {
    'jdtls',
    '--jvm-arg=-javaagent:' .. vim.fn.stdpath'data' .. '/mason/packages/jdtls/lombok.jar'
  },
})
require'lvim.lsp.manager'.setup('rust_analyzer', {
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
    }
  }
})
require'lvim.lsp.manager'.setup('lua_ls', {
  settings = {
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
})

local linters = require'lvim.lsp.null-ls.linters'
local formatters = require'lvim.lsp.null-ls.formatters'

linters.setup{
  {
    command = 'flake8',
    args = {'--max-line-length', '120'},
    filetypes = {'python'}
  }
}
formatters.setup{
  {
    command = 'black',
    filetypes = {'python'}
  },
  {
    command = 'google-java-format',
    filetypes = {'java'}
  }
}

--[[
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
--]]

--[[
    to make clipboard work with windows,
    just install the win32yank and put it on path,
    for example,
    C:\bin\win32yank.exe and C:\bin is on path
    https://github.com/equalsraf/win32yank/releases
--]]
