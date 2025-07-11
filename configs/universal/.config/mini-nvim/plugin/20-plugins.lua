local vars = CreaGlobals.vars
local funcs = CreaGlobals.funcs

local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none', -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

local deps = require('mini.deps')
local add, now, later = deps.add, deps.now, deps.later
deps.setup { path = { package = path_package } }

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

now(function()
  local map = funcs.map

  if vars.tabline then
    require('mini.tabline').setup {
      show_icons = false
    }

    map { mods = 'n', map = 'H', cmd = ':bprevious<CR>',
          opts = { silent = true, desc = 'Previous Tab' } }

    map { mods = 'n', map = 'L', cmd = ':bnext<CR>',
          opts = { silent = true, desc = 'Next Tab' } }

    map { mods = 'n', map = '[b', cmd = ':tabprevious<CR>',
          opts = { silent = true, desc = 'Previous Tab' } }

    map { mods = 'n', map = ']b', cmd = ':tabnext<CR>',
          opts = { silent = true, desc = 'Next Tab' } }
  else
    map { mods = 'n', map = 'H', cmd = ':tabprevious<CR>',
          opts = { silent = true, desc = 'Previous Tab' } }

    map { mods = 'n', map = 'L', cmd = ':tabnext<CR>',
          opts = { silent = true, desc = 'Next Tab' } }
  end
end)

now(function()
  local mini_notify = require('mini.notify')

  mini_notify.setup {
    window = { config = { border = 'double' } },
    content = {
      sort = function(notif_arr)
        return mini_notify.default_sort(vim.tbl_filter(function(notif)
          if notif.msg:find('Diagnosing') then return false end

          if notif.data.source == 'lsp_progress' then
            if notif.data.client_name == 'rust_analyzer' then
              if notif.data.response.token ~= 'rustAnalyzer/Fetching' then
                return false
              end
            end

            if not notif.msg:find('(100%%)') then return false end
          end

          return true
        end, notif_arr))
      end
    }
  }

  vim.notify = mini_notify.make_notify()
end)

later(function()
  local miniclue = require('mini.clue')

  miniclue.setup({
    window = { config = { border = 'double', width = 'auto' } },

    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      { mode = 'n', keys = '<C-c>' },
      { mode = 'v', keys = '<C-c>' },

      { mode = 'n', keys = '<C-w>' },

      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' }
    },

    clues = {
      {
        { mode = 'n', keys = '<Leader>s', desc = '+Search' },
        { mode = 'n', keys = '<Leader>g', desc = '+Gitsigns' },
        { mode = 'n', keys = '<Leader>l', desc = '+Lsp' }
      },

      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z()
    }
  })
end)

--== icons ==--

now(function()
  add { source = 'nvim-tree/nvim-web-devicons' }

  -- local mini_icons = require('mini.icons')
  -- mini_icons.setup()
  -- mini_icons.mock_nvim_web_devicons()
  -- mini_icons.tweak_lsp_kind()
end)

--== rooter ==--

now(function()
  add { source = 'airblade/vim-rooter' }
  vim.g.rooter_silent_chdir = 1
  vim.g.rooter_patterns = {
    '.project_root', '.git', '.luarc.json', 'compile_flags.txt'
  }
end)

--== color-schemes-themes ==--

now(function()
  -- add { source = 'hansumane/gruber-darker.nvim' }
  -- add { source = 'AlexvZyl/nordic.nvim' }
  -- add { source = 'navarasu/onedark.nvim' }
  add { source = 'rebelot/kanagawa.nvim' }

  vim.o.background = funcs.restore_bg(false)

  -- require('gruber-darker').setup()
  --
  -- require('nordic').setup {
  --   on_highlight = function(hi, c)
  --     hi.Todo = { fg = '#B48EAD' }
  --     -- mini.indentscope
  --     hi.MiniIndentscopeSymbol = { fg = c.gray3 }
  --     -- mini.tabline
  --     hi.MiniTablineCurrent = { fg = c.orange.base,   bg = c.black0, bold = true }
  --     hi.MiniTablineVisible = { fg = c.white0_normal, bg = c.gray1,  bold = true }
  --     hi.MiniTablineHidden  = { fg = c.white0_normal, bg = c.gray1 }
  --     hi.MiniTablineModifiedCurrent = { fg = c.black0, bg = c.orange.bright, bold = true }
  --     hi.MiniTablineModifiedVisible = { fg = c.black0, bg = c.white0_normal, bold = true }
  --     hi.MiniTablineModifiedHidden  = { fg = c.black0, bg = c.white0_normal }
  --     -- indent-blankline (ibl) v3
  --     hi.IblIndent     = { fg = c.gray1 }
  --     hi.IblWhitespace = { fg = c.gray1 }
  --     hi.IblScope      = { fg = c.gray3 }
  --     -- indent-blankline v2
  --     hi.IndentBlanklineChar               = { fg = c.gray1 }
  --     hi.IndentBlanklineSpaceChar          = { fg = c.gray1 }
  --     hi.IndentBlanklineSpaceCharBlankline = { fg = c.gray1 }
  --     hi.IndentBlanklineContextChar        = { fg = c.gray3 }
  --     hi.IndentBlanklineContextSpaceChar   = { fg = c.gray3 }
  --   end,
  -- }

  -- require('onedark').setup {
  --   style = 'dark',
  --   highlights = {
  --     MiniTablineCurrent = { fg = '$fg',         bg = '$bg0', fmt = 'bold' },
  --     MiniTablineVisible = { fg = '$light_grey', bg = '$bg1' },
  --     MiniTablineHidden  = { fg = '$light_grey', bg = '$bg1' },
  --     MiniTablineModifiedCurrent = { fg = '$bg_yellow', bg = '$bg0', fmt = 'bold' },
  --     MiniTablineModifiedVisible = { fg = '$orange',    bg = '$bg1' },
  --     MiniTablineModifiedHidden  = { fg = '$orange',    bg = '$bg1' },
  --   }
  -- }

  require('kanagawa').setup {
    compile = false,
    commentStyle = { italic = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    background = {
      dark = 'wave', -- d:'wave' or 'dragon'
      light = 'lotus' -- d:'lotus'
    },
    overrides = function(colors)
      local c = colors.theme

      return {
        MiniIndentscopeSymbol = { fg = c.ui.special },

        MiniTablineCurrent = { fg = c.ui.fg_dim, bg = c.ui.bg_p1, bold = true, underline = true },
        MiniTablineModifiedCurrent = { fg = c.ui.bg_p1, bg = c.ui.fg_dim, bold = true, underline = true },

        TodoBgFIX = { fg = c.ui.fg, bg = c.diag.error, bold = true },
        TodoFgFIX = { fg = c.diag.error },
        TodoSignFix = { link = 'TodoFgFIX' },

        TodoBgWARN = { fg = c.ui.fg_reverse, bg = c.diag.warning, bold = true },
        TodoFgWARN = { fg = c.diag.warning },
        TodoSignWARN = { link = 'TodoFgWARN' },

        TodoBgHACK = { link = 'TodoBgWARN' },
        TodoFgHACK = { link = 'TodoFgWARN' },
        TodoSignHACK = { link = 'TodoSignWARN' },

        TodoBgNOTE = { fg = c.ui.fg_reverse, bg = c.diag.hint, bold = true },
        TodoFgNOTE = { fg = c.diag.hint },
        TodoSignNOTE = { link = 'TodoFgNOTE' },

        TodoBgPERF = { link = 'TodoBgNote' },
        TodoFgPERF = { link = 'TodoFgNote' },
        TodoSignPERF = { link = 'TodoFgNOTE' },

        TodoBgTODO = { fg = c.ui.fg_reverse, bg = c.diag.info, bold = true },
        TodoFgTODO = { fg = c.diag.info },
        TodoSignTODO = { link = 'TodoFgTODO' }
      }
    end
  }

  funcs.au {
    name = 'ColorScheme',
    data = {
      callback = function()
        local highlights = {
          ["@lsp.type.comment"] = {},
          ["@lsp.type.comment.c"] = { link = "@comment" },
          ["@lsp.type.comment.cpp"] = { link = "@comment" },
          ["MiniIndentscopeSymbolOff"] = { link = "MiniIndentscopeSymbol" }
        }
        for group, highlight in pairs(highlights) do
          vim.api.nvim_set_hl(0, group, highlight)
        end
      end
    }
  }

  vim.cmd.colorscheme(vars.theme)
end)

--== statusline ==--

now(function()
  local mini_statusline = require('mini.statusline')
  local mini_statusline_combine_groups = mini_statusline.combine_groups
  mini_statusline.setup()
  mini_statusline.combine_groups = function(groups)
    table.insert(groups, 6, {
      hl = 'MiniStatuslineFilename',
      strings = { funcs.get_indent() }
    })
    --
    --  { hl = mode_hl,                  strings = { mode } },
    --  { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
    --  '%<', -- Mark general truncate point
    --  { hl = 'MiniStatuslineFilename', strings = { filename } },
    --  '%=', -- End left alignment
    --> { hl = 'MiniStatuslineFilename', strings = { funcs.get_indent() } },
    --  { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
    --  { hl = mode_hl,                  strings = { search, location } },
    --
    return mini_statusline_combine_groups(groups)
  end
end)

--== indent lines ==--

if vars.indentlines.ibl then
  now(function()
    add { source = 'lukas-reineke/indent-blankline.nvim' }
    require('ibl').setup(vars.ibl)
  end)
end
if vars.indentlines.mini then
  now(function()
    require('mini.indentscope').setup {
      symbol = vars.ibl_char,
      options = { border = 'top' },
      mappings = {
        object_scope_with_border = '',
        object_scope = '',
        goto_bottom = '',
        goto_top = '',
      },
    }
  end)
end

--== treesitter ==--

-- NOTE: It's required to put `tree-sitter` binary on PATH.
--       You can get it here: https://github.com/tree-sitter/tree-sitter/releases

now(function()
  add {
    source = 'nvim-treesitter/nvim-treesitter', checkout = 'main',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  }

  local ts = require('nvim-treesitter')

  ts.setup { install_dir = vim.fn.stdpath('data') .. '/site/treesitter' }

  vim.filetype.add {
    extension = {
      HC = 'hc',
      sh = 'bash',
      tmux = 'bash',
      json = 'jsonc',
      editorconfig = 'editorconfig',
    }
  }

  local ensure_installed = {
    'c', 'cpp', 'cmake', 'meson', 'python',
    'xml', 'jsonc', 'vimdoc', 'comment',
    'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
    -- for noice:
    'vim', 'lua', 'bash', 'regex', 'markdown', 'markdown_inline'
  }

  local ignored = {
    make = true
  }

  local renames = {
    devicetree = 'dts'
  }

  local available = {}
  for _, parser in ipairs(ts.get_available()) do
    parser = renames[parser] or parser
    if not ignored[parser] then
      available[#available + 1] = parser
    end
  end

  local installed = {}
  for _, parser in ipairs(ts.get_installed()) do
    parser = renames[parser] or parser
    installed[#installed + 1] = parser
  end

  ts.install(ensure_installed)

  funcs.au {
    name = 'FileType',
    data = {
      pattern = available,
      callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        if vim.list_contains(installed, ft) then
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
    source = 'nvim-neo-tree/neo-tree.nvim', monitor = 'main', checkout = 'v3.x',
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

--== telescope ==--

local telescope_add_or_later = vars.enable_cscope and now or later

telescope_add_or_later(function()
  add {
    source = 'nvim-telescope/telescope.nvim',
    depends = { 'nvim-lua/plenary.nvim' }
  }

  local telescope_delete_buffer = function(prompt_bufnr)
    require('telescope.actions.state')
      .get_current_picker(prompt_bufnr)
      :delete_selection(function(selection)
        local ok = pcall(funcs.buf_kill, selection.bufnr)
        return ok
      end)
  end

  local actions = require('telescope.actions')

  require('telescope').setup {
    defaults = {
      initial_mode = 'normal',
      sorting_strategy = "ascending",
      mappings = {
        -- <C-q> to open search results in a quickfix
        n = {
          ['q'] = actions.close,
          ['<C-g>'] = actions.close
        },
        i = {
          ['<C-g>'] = actions.close,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous
        }
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
        initial_mode = 'insert',
        mappings = {
          n = { ['dd'] = telescope_delete_buffer },
          i = { ['<C-d>'] = telescope_delete_buffer }
        }
      }
    }
  }

  local map = funcs.map
  local builtin = require('telescope.builtin')

  local builtin_buffers = function()
    builtin.buffers {
      ignore_current_buffer = true,
      sort_lastused = true
    }
  end

  map { mods = 'n', map = '<leader>b', cmd = builtin_buffers,
        opts = { silent = true, desc = 'Telescope: Buffers' } }

  map { mods = 'n', map = '<leader>se', cmd = builtin.live_grep,
        opts = { silent = true, desc = 'Telescope: Search' } }

  map { mods = 'n', map = '<leader>sf', cmd = builtin.find_files,
        opts = { silent = true, desc = 'Telescope: Files' } }
end)

--== ctags / cscope_maps ==--

-- When opening project file from outside of project, plugin fails to properly build path
-- to cscope.out, for example, if the project is in ~/projects/project, and CWD is
-- ~/projects, and one opens ./project/main.c, the path to cscope.out will be
-- ../project/main.c, HOWEVER symbols from cscope.out will be loaded
--
-- At least with { cscope = { project_rooter = { enable = true } } } it correctly finds
-- cscope.out, when CWD is within the project (inside project root and any depth subfolder)

-- Cannot use `later()` with cscope, because `later()` loads the plugin after FileType
-- event, so keymaps won't work, if `.c` file is the first one you open

if vars.enable_cscope then
  now(function()
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
          map('<C-c>r', function() cscope_wrap('CsPrompt c') end, 'References Prompt')
          map('<C-c><C-g>', function() cscope_wrap('Cscope find g') end, 'Definition')
          map('<C-c><C-r>', function() cscope_wrap('Cscope find c') end, 'References')
        end
      }
    }
  end)
end

--== colorizer ==--

later(function()
  add { source = 'norcalli/nvim-colorizer.lua' }

  local opts = {
    [ 'lua'  ] = { RGB = false, RRGGBB = true, names = false },
    [ 'vim'  ] = { RGB = false, RRGGBB = true, names = false },
    [ 'conf' ] = { RGB = false, RRGGBB = true, names = false },
    [ 'bash' ] = { RGB = false, RRGGBB = true, names = false },
  }

  require('colorizer').setup(opts)
end)

--== autopairs ==--

later(function()
  add { source = 'altermo/ultimate-autopair.nvim', checkout = 'v0.6' }
  require('ultimate-autopair').setup()
  -- require('mini.pairs').setup()
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

  local rust_analyzer_lspconfig_on_attach = vim.lsp.config['rust_analyzer'].on_attach

  local wanted_servers = {
    -- sourcekit = { enabled = false, config = nil },
    yang_lsp = { enabled = false, config = nil },
    clangd = { enabled = false, config = nil },
    zls = { enabled = false, config = nil },
    lua_ls = {
      enabled = false,
      config = {
        settings = {
          Lua = {
            -- <.luarc.json>
            runtime = { version = "Lua 5.4" },
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
        -- flags = { debounce_text_changes = 150 },
        settings = {
          ["rust-analyzer"] = {
            -- lens = { implementations = { enable = false } },
            check = { command = "clippy" },
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
        local map = function(map, cmd, desc)
          funcs.map {
            mods = 'n', map = map, cmd = cmd,
            opts = {
              silent = true,
              -- noremap = true,
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
    flake8 = {
      ft = 'python',
      args_force = false,
      args = { '--max-line-length', '120' },
      parser = nil
    },
    checkpatch = {
      ft = 'c',
      args_force = true,
      args = {
        '--no-tree',
        '--no-signoff', '--show-types', '--strict', '--terse', '--file',
        '--ignore', table.concat({
          'PREFER_KERNEL_TYPES',
          'SPDX_LICENSE_TAG', 'FILE_PATH_CHANGES', 'COMMIT_MESSAGE'
        }, ',')
      },
      parser = require('lint.parser').from_pattern(
        '([^:]+):(%d+): (%a+):([%a_]+): (.+)',
        { 'file', 'lnum', 'severity', 'code', 'message' },
        { ['ERROR'] = vim.diagnostic.severity.ERROR,
          ['WARNING'] = vim.diagnostic.severity.WARN,
          ['CHECK'] = vim.diagnostic.severity.INFO },
        { source = 'checkpatch' }
      )
    }
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
    if settings.args_force then
      lint.linters[linter].args = settings.args
    else
      vim.list_extend(lint.linters[linter].args, settings.args)
    end
    if settings.parser then
      lint.linters[linter].parser = settings.parser
    end
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
    highlight = { keyword = "bg", max_line_len = 140 },
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

later(function()
  add { source = 'https://github.com/tpope/vim-fugitive.git' }
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
    source = 'L3MON4D3/LuaSnip', monitor = 'master', checkout = 'v2.4.0',
    hooks = { post_install = build_luasnip, post_checkout = build_luasnip }
  }
  add {
    source = 'Saghen/blink.cmp', monitor = 'main', checkout = 'v1.7.0',
    depends = { 'rafamadriz/friendly-snippets' }
  }

  require('blink.cmp').setup {
    cmdline = { enabled = false },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'snippets', 'buffer', 'path' },
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

--== terminal ==--

-- TODO: Make insert on terminal open and escape on terminal close

later(function()
  add { source = 'akinsho/toggleterm.nvim', monitor = 'main', checkout = 'v2.13.1' }

  require('toggleterm').setup()

  funcs.map { mods = 'n', map = '<C-t>', cmd = ':ToggleTerm<CR><C-\\><C-n>',
              opts = { silent = true, desc = 'ToggleTerm: Open' } }

  funcs.map { mods = 't', map = '<C-t>', cmd = '<C-\\><C-n>:ToggleTerm<CR>',
              opts = { silent = true, desc = 'ToggleTerm: Close' } }
end)

-- Repos to be tracked because of checkout to a specific tag:
-- https://github.com/altermo/ultimate-autopair.nvim --
-- https://github.com/L3MON4D3/LuaSnip
-- https://github.com/Saghen/blink.cmp ++
-- https://github.com/akinsho/toggleterm.nvim
