local vars = CreaGlobals.vars
local funcs = CreaGlobals.funcs

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  funcs.set_number(true)

  require('editorconfig').properties.max_line_length = function(_, val)
    local n = tonumber(val)
    if n then
      funcs.update_cc(nil, n + 1)
    else
      assert(val == 'off', 'editorconfig: max_line_length: not number or "off"')
      funcs.update_cc(nil, vars.cd_init)
    end
  end
end)

later(function()
  local com = function(cmd, func) vim.api.nvim_create_user_command(cmd, func, {}) end

  com('SN',  function() funcs.set_number(true) end)
  com('USN', function() funcs.set_number(false) end)
  com('S2',  function() funcs.set_indent { spaces = 2 } end)
  com('S4',  function() funcs.set_indent { spaces = 4 } end)
  com('S8',  function() funcs.set_indent { spaces = 8 } end)
  com('T2',  function() funcs.set_indent { spaces = 2, tabs = 2, noexpand = true } end)
  com('T4',  function() funcs.set_indent { spaces = 4, tabs = 4, noexpand = true } end)
  com('T8',  function() funcs.set_indent { spaces = 8, tabs = 8, noexpand = true } end)
  com('M2',  function() funcs.set_indent { spaces = 2, tabs = 4, noexpand = true } end)
  com('M4',  function() funcs.set_indent { spaces = 4, tabs = 8, noexpand = true } end)
  com('MG',  function() funcs.set_indent { spaces = 2, tabs = 8, noexpand = true } end)
end)

--== minis ==--

now(function() require('mini.tabline').setup() end)
now(function() require('mini.statusline').setup() end)
later(function() require('mini.cursorword').setup() end)

now(function()
  require('mini.notify').setup {
    content = {
      sort = function(notif_arr)
        return MiniNotify.default_sort(vim.tbl_filter(function(notif)
          if notif.msg:find('Diagnosing') then return false end

          -- if not (notif.data.source == 'lsp_progress' and
          --         notif.data.client_name == 'lua_ls')
          -- then return false end

          return true
        end, notif_arr))
      end
    }
  }
  vim.notify = MiniNotify.make_notify()
end)

now(function()
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
  MiniIcons.tweak_lsp_kind()
end)

--== rooter ==--

now(function()
  add { source = 'airblade/vim-rooter' }
  vim.g.rooter_silent_chdir = 1
  vim.g.rooter_patterns = { '.git', '.vi_project_root' }
end)

--== colorthemes ==--

now(function()
  add { source = 'AlexvZyl/nordic.nvim' }

  vim.opt.background = 'dark'

  require('nordic').setup {
    on_highlight = function(highlights, palette)
      highlights.Todo = { fg = '#B48EAD' }
      -- mini.indentscope
      highlights.MiniIndentscopeSymbol = { fg = palette.gray3 }
      -- mini.tabline
      highlights.MiniTablineCurrent = { fg = palette.cyan.bright, bg = palette.black0, bold = true }
      highlights.MiniTablineVisible = { fg = palette.white0_normal, bg = palette.gray1, bold = true }
      highlights.MiniTablineHidden = { fg = palette.white0_normal, bg = palette.gray1 }
      highlights.MiniTablineModifiedCurrent = { fg = palette.black0, bg = palette.cyan.base, bold = true }
      highlights.MiniTablineModifiedVisible = { fg = palette.black0, bg = palette.white0_normal, bold = true }
      highlights.MiniTablineModifiedHidden = { fg = palette.black0, bg = palette.white0_normal }
      -- indent-blankline (ibl) v3
      highlights.IblIndent = { fg = palette.gray1 }
      highlights.IblWhitespace = { fg = palette.gray1 }
      highlights.IblScope = { fg = palette.gray3 }
      -- indent-blankline v2
      highlights.IndentBlanklineChar = { fg = palette.gray1 }
      highlights.IndentBlanklineSpaceChar = { fg = palette.gray1 }
      highlights.IndentBlanklineSpaceCharBlankline = { fg = palette.gray1 }
      highlights.IndentBlanklineContextChar = { fg = palette.gray3 }
      highlights.IndentBlanklineContextSpaceChar = { fg = palette.gray3 }
    end,
  }

  vim.cmd.colorscheme(vars.theme)
  vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolOff", { link = "MiniIndentscopeSymbol" })
end)

--== indent lines ==--

if vars.enable_indentlines then
  now(function()
    add { source = 'lukas-reineke/indent-blankline.nvim' }

    require('ibl').setup(vars.ibl)

    require('mini.indentscope').setup {
      symbol = vars.ibl_char,
      mappings = {
        -- Textobjects
        object_scope = '', -- 'ii'
        object_scope_with_border = '', -- 'ai'
        -- Motions (jump to respective border line; if not present - body line)
        goto_top = '', -- '[i'
        goto_bottom = '', -- ']i'
      },
      options = {
        border = 'top' -- 'both' | 'top' | 'bottom' | 'none'
      }
    }
  end)
end

--== treesitter ==--

-- NOTE: It's required to put `tree-sitter` binary on PATH.
--       You can get it here: https://github.com/tree-sitter/tree-sitter/releases

now(function()
  add {
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'main',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  }

  local ts = require('nvim-treesitter')

  ts.setup { install_dir = vim.fn.stdpath('data') .. '/site/treesitter' }

  vim.filetype.add {
    extension = {
      sh = 'bash',
      json = 'jsonc',
      editorconfig = 'editorconfig',
    }
  }

  local ensure_installed = {
    'c', 'cpp', 'make', 'cmake', 'meson', 'python',
    'xml', 'jsonc', 'vimdoc', 'comment',
    'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
    -- for noice:
    'vim', 'lua', 'bash', 'regex', 'markdown', 'markdown_inline'
  }

  ts.install(ensure_installed)

  funcs.au {
    name = 'FileType',
    data = {
      pattern = ts.get_available(),
      callback = function(ev)
        local ft = vim.bo[ev.buf].filetype

        if vim.list_contains(ts.get_installed(), ft) then
          vim.treesitter.start()
        else
          vim.schedule(function()
            local msg = "TreeSitter: '%s' parser is available, but not installed"
            vim.notify(msg:format(ft), vim.log.levels.WARN)
          end)
        end
      end
    }
  }
end)

--== neo-tree ==--

now(function()
  add {
    source = 'nvim-neo-tree/neo-tree.nvim', checkout = 'v3.x',
    depends = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- 'nvim-tree/nvim-web-devicons',
      -- { '3rd/image.nvim', opts = {} } -- image support
    }
  }

  require('neo-tree').setup {
    close_if_last_window = true,
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      filtered_items = {
        hide_gitignored = false,
        hide_dotfiles = false,
        never_show = { '.git' },
        hide_by_name = { '.github' }
      }
    },
    window = {
      mappings = {
        ['E'] = 'expand_all_subnodes',
        ['W'] = 'close_all_subnodes',
        ['h'] = 'navigate_up',
        ['C'] = 'set_root'
      }
    }
  }

  local map = funcs.map

  map { mods = 'n', map = '<leader>e',
        cmd = ':Neotree toggle reveal_force_cwd<CR>',
        opts = { silent = true, noremap = true, desc = 'Neotree: Normal' } }

  map { mods = 'n', map = '<leader>/',
        cmd = ':Neotree toggle current reveal_force_cwd<CR>',
        opts = { silent = true, noremap = true, desc = 'Neotree: Fullscreen' } }
end)

--== colorizer ==--

later(function()
  add { source = 'norcalli/nvim-colorizer.lua' }

  local opts = {
    [ 'lua'  ] = { RGB = false, RRGGBB = true, names = false },
    [ 'vim'  ] = { RGB = false, RRGGBB = true, names = false },
    [ 'conf' ] = { RGB = false, RRGGBB = true, names = false },
    [ 'bash' ] = { RGB = false, RRGGBB = true, names = false },
  }

  -- require('colorizer').setup(opts)
end)

--== autopairs ==--

later(function()
  add { source = 'altermo/ultimate-autopair.nvim', checkout = 'v0.6' }
  -- require('ultimate-autopair').setup{}
end)

--== telescope ==--

later(function()
  add {
    source = 'nvim-telescope/telescope.nvim',
    depends = { 'nvim-lua/plenary.nvim' }
  }

  local telescope_delete_buffer = function(prompt_bufnr)
    local buf_kill = require('defaults').funcs.buf_kill
    local action_state = require('telescope.actions.state')
    local current_picker = action_state.get_current_picker(prompt_bufnr)

    current_picker:delete_selection(function(selection)
      local ok = pcall(buf_kill, selection.bufnr)
      return ok
    end)
  end

  require('telescope').setup {
    defaults = {
      initial_mode = 'normal',
      sorting_strategy = "ascending",
      mappings = {
        -- <C-q> to open search results in a quickfix
        n = { ['q'] = require('telescope.actions').close }
      },
      layout_config = {
        preview_width = 0.6,
        width = { padding = 0 }, -- width = 1.0, -- doesn't work
        height = { padding = 0 }, -- height = 1.0, -- doesn't work
        prompt_position = 'top'
      }
    },
    pickers = {
      find_files = {
        initial_mode = 'insert'
      },
      live_grep = {
        initial_mode = 'insert',
        additional_args = { '--pcre2' }
      },
      buffers = {
        initial_mode = 'normal',
        mappings = {
          n = { ['dd'] = telescope_delete_buffer }
        }
      }
    }
  }

  local map = funcs.map
  local builtin = require('telescope.builtin')

  map { mods = 'n', map = '<leader>b', cmd = builtin.buffers,
        opts = { silent = true, desc = 'Telescope: Buffers' } }

  map { mods = 'n', map = '<leader>se', cmd = builtin.live_grep,
        opts = { silent = true, desc = 'Telescope: Search' } }

  map { mods = 'n', map = '<leader>sf', cmd = builtin.find_files,
        opts = { silent = true, desc = 'Telescope: Files' } }
end)

--== Trouble ==--

later(function()
  add {
    source = 'folke/trouble.nvim',
    -- depends = { 'nvim-tree/nvim-web-devicons' }
  }

  require('trouble').setup{}

  funcs.map { mods = 'n', map = '<leader>lx',
              opts = { silent = true, desc = 'Trouble: Diagnostics' },
              cmd = ':Trouble diagnostics toggle focus=true filter.buf=0<CR>' }
end)

--== LSP ==--

later(function()
  add {
    source = 'neovim/nvim-lspconfig',
    depends = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim'
    }
  }

  require('mason').setup()

  local wanted_servers = {
    yang_lsp = { enabled = false, config = nil },
    clangd = { enabled = false, config = nil },
    lua_ls = { enabled = false, config = {
      settings = {
        Lua = {
          runtime = { version = "Lua 5.4" },
          workspace = {
            library = {
              '/usr/share/lua/5.4',
              -- '~/virtual/lxc/projects/container-lua',
              -- '~/virtual/lxc/projects/container-definitions-lua',
            }
          }
        }
      }
    }}
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
    if not server.enabled and cfg ~= nil and vim.fn.executable(cfg.cmd[1]) then
      if server.config ~= nil then
        vim.lsp.config(name, server.config)
      end
      vim.lsp.enable(name)
    end
  end

  for wanted_server, is_set in pairs(wanted_servers) do
    local server_cfg = vim.lsp.config[wanted_server]
    if server_cfg ~= nil and not is_set and vim.fn.executable(server_cfg.cmd[1]) then
      vim.lsp.enable(wanted_server)
    end
  end

  vim.diagnostic.config {
    underline = false,
    virtual_text = true,
    update_in_insert = false,
    -- virtual_text = { -- virtual_lines = true,
    --   current_line = true, -- show only when the cursor is on the line with diagnostic
    --   severity = { min = 'WARN', max = 'ERROR' }
    -- },
    -- signs = {
    --   priority = 9999,
    --   severity = { min = 'WARN', max = 'ERROR' },
    --   text = {
    --     [ vim.diagnostic.severity.ERROR ] = 'x', -- '󰅚 ',
    --     [ vim.diagnostic.severity.WARN  ] = '!', -- '󰀪 ',
    --     [ vim.diagnostic.severity.INFO  ] = '*', -- '󰋽 ',
    --     [ vim.diagnostic.severity.HINT  ] = '?', -- '󰌶 ',
    --   }
    -- }
  }

  funcs.au {
    name = 'LspAttach',
    data = {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(ev)
        local builtin = require('telescope.builtin')
        local map = function(map, cmd, desc)
          funcs.map {
            mods = 'n', map = map, cmd = cmd,
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

        -- do not replace default tags with LSP definition
        vim.bo[ev.buf].tagfunc = nil
      end
    }
  }
end)

--== linters ==--

later(function()
  add { source = 'mfussenegger/nvim-lint' }

  local linters = {
    flake8 = { ft = 'python', args = { '--max-line-length', '120' } }
  }

  local remove_lint_diagnostic = function()
    for i, ns in pairs(vim.diagnostic.get_namespaces()) do
      if linters[ns.name] ~= nil then
        vim.diagnostic.reset(i)
      end
    end
  end

  local lint = require('lint')

  for linter, settings in pairs(linters) do
    vim.list_extend(lint.linters[linter].args, settings.args)
    lint.linters_by_ft[settings.ft] = { linter }
  end

  local map = funcs.map

  map { mods = 'n', map = '<leader>ll', cmd = lint.try_lint,
       opts = { desc = 'Lint: Try Lint' } }

  map { mods = 'n', map = '<leader>lh', cmd = remove_lint_diagnostic,
        opts = { desc = 'Lint: Hide Lint' } }
end)

--== todo-comments ==--

later(function()
  add {
    source = 'folke/todo-comments.nvim',
    depends = { 'nvim-lua/plenary.nvim' }
  }

  require('todo-comments').setup {
    keywords = {
      -- FIXME
      -- ERROR
      -- FIXME: test
      -- ERROR: test
      -- ISSUE: test
      -- BUG: test
      FIX  = { icon = 'F-', color = 'error', alt = { 'FIXME', 'ERROR', 'ISSUE', 'BUG' } },
      -- WARN
      -- WARN: test
      -- WARNING: test
      -- HACK: test
      WARN = { icon = 'W-', color = 'warning', alt = { 'WARNING' } },
      HACK = { icon = 'W-', color = 'warning', alt = {} },
      -- REV
      -- REV: test
      -- REVIEW: test
      REV  = { icon = 'R-', color = 'review', alt = { 'REVIEW' } },
      -- NOTE
      -- NOTE: test
      -- INFO: test
      -- PERF: test
      NOTE = { icon = 'N-', color = 'note', alt = { 'INFO' } },
      PERF = { icon = 'N-', color = 'note', alt = {} },
      -- TODO
      -- TODO: test
      TODO = { icon = 'D-', color = 'todo', alt = {} }
    },
    colors = {
      error   = { 'DiagnosticError' },
      warning = { 'DiagnosticWarn' },
      review  = { 'DiagnosticOk' },
      note    = { 'DiagnosticInfo' },
      todo    = { 'Todo' }
    }
  }

  funcs.map { mods = 'n', map = '<leader>st',
              opts = { silent = true, desc = 'Trouble: TODO' },
              cmd = ':Trouble todo toggle focus=true filter.buf=0<CR>' }
end)

--== gitsigns ==--

later(function()
  add { source = 'lewis6991/gitsigns.nvim' }

  require('gitsigns').setup()

  local map = funcs.map

  map { mods = 'n', map = '<leader>gb', cmd = ':Gitsigns blame<CR>',
        opts = { silent = true, desc = 'Gitsigns: Blame' } }

  map { mods = 'n', map = '<leader>gl', cmd = ':Gitsigns blame_line<CR>',
       opts = { silent = true, desc = 'Gitsigns: Blame Line' } }

  map { mods = 'n', map = '<leader>gj', cmd = ':Gitsigns next_hunk<CR>',
        opts = { silent = true, desc = 'Gitsigns: Go to Next Hunk' } }

  map { mods = 'n', map = '<leader>gk', cmd = ':Gitsigns prev_hunk<CR>',
        opts = { silent = true, desc = 'Gitsigns: Go to Previous Hunk' } }
end)

--== blink completions and luasnip ==--

later(function()
  local build_luasnip = function(params)
    vim.notify('Building `LuaSnip`', vim.log.levels.INFO)
    local ret = vim.system(
      { 'make', 'install_jsregexp' },
      { cwd = params.path }
    ):wait()
    if ret.code ~= 0 then
      vim.notify('Building `LuaSnip` failed', vim.log.levels.ERROR)
    else
      vim.notify('Building `LuaSnip` done', vim.log.levels.INFO)
    end
  end

  add {
    source = 'L3MON4D3/LuaSnip', checkout = 'v2.4.0',
    hooks = { post_install = build_luasnip, post_checkout = build_luasnip }
  }
  add {
    source = 'Saghen/blink.cmp', checkout = 'v1.4.1',
    depends = { 'rafamadriz/friendly-snippets' }
  }

  require('blink.cmp').setup {
    cmdline = { enabled = false },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = { fallbacks = {} } ,
        path = { opts = { show_hidden_files_by_default = true } }
      }
    },
    keymap = {
      preset = 'none',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<TAB>'] = { 'accept', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' }
    },
    completion = {
      menu = {
        scrolloff = 1,
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' }
          }
        }
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true
        }
      }
    }
  }

  require('luasnip.loaders.from_vscode').lazy_load()
end)

--== ctags / cscope_maps ==--

-- When opening project file from outside of project, plugin fails to properly build path
-- to cscope.out, for example, if the project is in ~/projects/project, and CWD is
-- ~/projects, and one opens ./project/main.c, the path to cscope.out will be
-- ../project/main.c, HOWEVER symbols from cscope.out will be loaded
--
-- At least with { cscope = { project_rooter = { enable = true } } } it correctly finds
-- cscope.out, when CWD is within the project (inside project root and any depth subfolder)

if vars.enable_cscope then
  later(function()
    add { source = 'dhananjaylatkar/cscope_maps.nvim' }

    local prev_cwd = ''
    local cscope_wrap = function(cmd)
      local cur_cwd = vim.fn.getcwd()
      if cur_cwd ~= prev_cwd then
        prev_cwd = cur_cwd
        vim.cmd('Cscope reload')
      end
      vim.cmd(cmd)
    end

    require('cscope_maps').setup {
      prefix = '',
      disable_maps = true,
      cscope = { picker = 'telescope' }
    }

    funcs.au {
      name = 'FileType',
      data = {
        pattern = { 'c', 'cpp' },
        callback = function(ev)
          local map = function(map, cmd, desc)
            funcs.map {
              mods = { 'n', 'v' },
              map = map,
              cmd = cmd,
              opts = {
                silent = true,
                noremap = true,
                buffer = ev.buf,
                desc = 'Cscope: ' .. desc
              }
            }
          end

          map('<C-c>g', function() cscope_wrap('CsPrompt g') end, 'Definition Prompt')
          map('<C-c><C-g>', function() cscope_wrap('Cscope find g') end, 'Definition')
          map('<C-c><C-r>', function() cscope_wrap('Cscope find c') end, 'References')
        end
      }
    }
  end)
end

--== terminal ==--

-- TODO: Make insert on terminal open and escape on terminal close

later(function()
  add { source = 'akinsho/toggleterm.nvim', checkout = 'v2.13.1' }

  require('toggleterm').setup()

  funcs.map { mods = 'n', map = '<C-t>',
              cmd = ':ToggleTerm<CR><C-\\><C-n>',
              opts = { silent = true, desc = 'ToggleTerm: Open' } }

  funcs.map { mods = 't', map = '<C-t>',
              cmd = '<C-\\><C-n>:ToggleTerm<CR>',
              opts = { silent = true, desc = 'ToggleTerm: Close' } }
end)
