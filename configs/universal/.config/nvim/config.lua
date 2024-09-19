-- LunarVim (lvim) config

vim.opt.mouse = "nv"
vim.opt.scrolloff = 3
vim.g.c_syntax_for_h = true
vim.g.c_style = ""

vim.opt.keymap = "russian-jcukenwin"
vim.opt.iminsert = 0
vim.opt.imsearch = 0

-- vim.cmd[[set iskeyword-=_]]
vim.opt.showbreak = "↪"
vim.opt.listchars = {
  tab = "   ",
  trail = "␣",
  precedes = "⟨",
  extends = "⟩",
}

local cd_init = 81
local cc_dict = {
  init = cd_init,
  current = cd_init,
  ["81"] = 91,
  ["91"] = 101,
  ["101"] = 121,
  ["121"] = 81,
}

local enable_guidelines = true
local update_cc = function(info, new_cc)
  if not new_cc then
    new_cc = cc_dict[vim.opt.colorcolumn:get()[1]] or cc_dict.init
  end

  cc_dict.current = new_cc
  vim.opt.textwidth = new_cc - 1
  if vim.opt.number:get() then
    vim.opt.colorcolumn = { new_cc }
  end

  if info then
    vim.print(info .. "cc: " .. (new_cc - 1))
  end
end

require("editorconfig").properties.max_line_length = function(_, val)
  local n = tonumber(val)
  if n then
    update_cc(nil, n + 1)
  else
    assert(val == "off", 'editorconfig: max_line_length: not number or "off"')
    update_cc(nil, cc_dict.init)
  end
end

function RestoreBG(store)
  local mode = ((store and "w") or "r")
  local new_theme = ((vim.opt.background:get() == "dark" and "light") or "dark")
  local file, err = io.open(vim.fn.stdpath("config") .. "/theme.txt", mode)

  if store then
    if not file then
      vim.notify("Cannot open background file: " .. err, vim.log.levels.ERROR)
    else
      file:write(new_theme)
      file:close()
    end

    vim.opt.background = new_theme
    return new_theme
  else
    if not file then
      return "dark"
    end

    for line in file:lines() do
      new_theme = ((line == "light" and "light") or "dark")
      break
    end

    file:close()
    return new_theme
  end
end

lvim.builtin.which_key.mappings["w"] = {}
lvim.builtin.which_key.mappings["h"] = {}
lvim.builtin.terminal.open_mapping = "<C-t>"

lvim.keys.insert_mode["<C-\\>"] = "<C-6>"
lvim.keys.insert_mode["<C-r>"] = "<C-v><C-i>"
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-n>"] = "<cmd>BufferLineMovePrev<CR>"
lvim.keys.normal_mode["<S-m>"] = "<cmd>BufferLineMoveNext<CR>"
lvim.keys.normal_mode["<C-c><C-g>"] = "<cmd>Cscope find g<CR>"
lvim.keys.normal_mode["<C-c><C-r>"] = "<cmd>Cscope find c<CR>"

lvim.lsp.buffer_mappings.normal_mode.gr = {
  [[<cmd>lua require("telescope.builtin").lsp_references()<CR>]],
  "References"
}
lvim.builtin.which_key.mappings.i = {
  [[<cmd>Inspect<CR>]],
  "Inspect"
}
lvim.builtin.which_key.vmappings.i = {
  [[<cmd>Inspect<CR>]],
  "Inspect"
}
lvim.builtin.which_key.mappings.h = {
  [[<cmd>Telescope highlights<CR>]],
  "Highlights"
}
lvim.builtin.which_key.mappings.lx = {
  [[<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>]],
  "Buffer Diagnostics (Trouble)"
}
lvim.builtin.which_key.mappings.lt = {
  [[<cmd>TodoTelescope<CR>]],
  "TODOs"
}
lvim.builtin.which_key.mappings.se = {
  [[<cmd>lua require("telescope.builtin").live_grep({ additional_args = function(opts) return { "--pcre2" } end })<CR>]],
  "PCRE2"
}
lvim.builtin.which_key.mappings.t = {
  [[<cmd>lua RestoreBG(true)<CR>]],
  'Change dark/light'
}

-- :sort<CR> is intentional, <cmd>sort<CR> doesn't work
lvim.builtin.which_key.vmappings.k = { ":sort<CR>", "Sort Lines" }
lvim.builtin.which_key.mappings.j = { "<cmd>noh<CR>", "No Highlight" }

lvim.keys.normal_mode["<C-j>"] = function()
  update_cc("")
end

lvim.keys.normal_mode["<C-k>"] = function()
  if not vim.opt.listchars:get().space then
    if enable_guidelines then require("indent_blankline.commands").disable(true) end
    vim.opt.listchars = {
      tab = "-->",
      space = "⋅",
      trail = "␣",
      precedes = "⟨",
      extends = "⟩",
    }
    vim.print("Indent Guidelines: off")
  else
    vim.opt.listchars = {
      tab = "   ",
      trail = "␣",
      precedes = "⟨",
      extends = "⟩",
    }
    if enable_guidelines then require("indent_blankline.commands").enable(true) end
    vim.print("Indent Guidelines: on")
  end
end

function SetNumber(toggle)
  vim.opt.textwidth = toggle and (cc_dict.current - 1) or 0
  vim.opt.colorcolumn = toggle and { cc_dict.current } or {}
  vim.opt.number = toggle and true or false
  vim.opt.cursorline = toggle and true or false
  vim.opt.relativenumber = toggle and true or false
  vim.opt.list = toggle and true or false
end

function SetIndent(settings)
  local shift = settings.spaces or 4
  local tabst = settings.tabs or 8
  local stabs = settings.tabs or 8
  local noexpand = settings.noexpand

  vim.opt.shiftwidth = shift
  vim.opt.tabstop = tabst
  vim.opt.softtabstop = stabs
  vim.opt.expandtab = not noexpand and true or false
end

lvim.format_on_save.enabled = false
lvim.builtin.nvimtree.setup.view.adaptive_size = true
lvim.builtin.indentlines.options.use_treesitter = true
if not enable_guidelines then lvim.builtin.indentlines.active = false end

lvim.builtin.telescope.defaults.initial_mode = "normal"
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config.width = 0.9
lvim.builtin.telescope.defaults.layout_config.height = 0.9
lvim.builtin.telescope.defaults.layout_config.preview_width = 0.55
lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"

lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.sync_install = false
lvim.builtin.treesitter.indent.enable = false
lvim.builtin.treesitter.highlight.enable = true
table.insert(lvim.builtin.treesitter.indent.disable, "c")
table.insert(lvim.builtin.treesitter.indent.disable, "cpp")

vim.lsp.set_log_level"off"
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "jedi_language_server"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- lvim.builtin.treesitter.auto_install = false
lvim.lsp.automatic_servers_installation = false
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.installer.setup.ensure_installed = {
  "lua_ls", "clangd", "rust_analyzer", "pyright", "jdtls"
} -- black, google-java-format --
lvim.builtin.treesitter.ensure_installed = {
  "bash", "c", "cpp", "java", "lua", "python", "rust", "php",
  "vim", "vimdoc", "org", "comment", "markdown", "markdown_inline",
  "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore"
} -- norg --
lvim.builtin.treesitter.ignore_install = {
  "make", "tmux"
}

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_b = {
  function()
    local isvm = vim.fn.mode():find("[vV]")
    if not isvm then return "" end

    local starts = vim.fn.line("v")
    local ends = vim.fn.line(".")
    local lines = starts <= ends and ends - starts + 1 or starts - ends + 1

    if lines <= 1 then
      return "" .. vim.fn.wordcount().visual_chars .. "C"
    else
      return "" .. lines .. "L"
    end
  end
}
lvim.builtin.lualine.sections.lualine_x = {
  components.lsp,
  components.filetype,
  function()
    if vim.opt.iminsert:get() ~= 0 then
      return "RU"
    else
      return "EN"
    end
  end
}
lvim.builtin.lualine.sections.lualine_y = {
  function()
    local shift = vim.opt.shiftwidth:get()
    local tabst = vim.opt.tabstop:get()
    local expand = vim.opt.expandtab:get()
    local result = shift .. "/" .. tabst .. "-"
    if expand then
      result = result .. "S"
    elseif shift ~= tabst then
      result = result .. "M"
    else
      result = result .. "T"
    end
    return result
  end
}

lvim.autocommands = {
  {
    "VimEnter", {
      callback = function()
        vim.cmd[[
        command! SN :lua SetNumber(true)
        command! USN :lua SetNumber(false)
        command! S2 :lua SetIndent{ spaces = 2 }
        command! S4 :lua SetIndent{ spaces = 4 }
        command! S8 :lua SetIndent{ spaces = 8 }
        command! T2 :lua SetIndent{ spaces = 2, tabs = 2, noexpand = true }
        command! T4 :lua SetIndent{ spaces = 4, tabs = 4, noexpand = true }
        command! T8 :lua SetIndent{ spaces = 8, tabs = 8, noexpand = true }
        command! M2 :lua SetIndent{ spaces = 2, tabs = 4, noexpand = true }
        command! M4 :lua SetIndent{ spaces = 4, tabs = 8, noexpand = true }
        command! MG :lua SetIndent{ spaces = 2, tabs = 8, noexpand = true }
        Cscope db add /home/user/path/to/cscope.out:/home/user/path/to
        ]]
        SetNumber(true)
      end
    },
  },
  {
    "QuitPre", {
      callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()

        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= "" then
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
  },
  {
    "FileType", {
      pattern = "org",
      callback = function()
        vim.wo.wrap = true
        vim.wo.linebreak = true
      end
    }
  },
  {
    "FileType", {
      pattern = "c,cpp",
      callback = function()
        if vim.g.c_style == "GNU" then
          vim.bo.cindent = true
          vim.bo.cinoptions = "(0,f0,t0,:s,^-s,>2s,{s,Ws,n-s" -- sw=2 ts=8 noet
        end
      end
    }
  }
}

local background = RestoreBG(false)
local themes = {
  catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1500,
    lazy = false,
    config = function()
      vim.opt.background = background
      require("catppuccin").setup({
        background = {
          dark = "mocha",
          light = "latte"
        },
        custom_highlights = function(colors)
          return {
            IndentBlanklineChar = { fg = colors.surface0 },
            IndentBlanklineSpaceChar = { fg = colors.surface0 },
            IndentBlanklineSpaceCharBlankline = { fg = colors.surface0 },
            IndentBlanklineContextChar = { fg = colors.surface2 },
            IndentBlanklineContextSpaceChar = { fg = colors.surface2 },
          }
        end
      })
      lvim.colorscheme = "catppuccin"
    end
  },
  everforest = {
    "sainnhe/everforest",
    priority = 1500,
    lazy = false,
    config = function()
      vim.opt.background = background
      vim.g.everforest_background = "hard"
      vim.g.everforest_better_performance = 1
      lvim.colorscheme = "everforest"
    end
  },
  gruvbox_material = {
    "sainnhe/gruvbox-material",
    priority = 1500,
    lazy = false,
    config = function()
      vim.opt.background = background
      vim.g.gruvbox_material_background = "hard" -- medium (default), soft
      vim.g.gruvbox_material_better_performance = 1
      lvim.colorscheme = "gruvbox-material"
    end
  },
  sonokai = {
    "sainnhe/sonokai",
    priority = 1500,
    lazy = false,
    config = function()
      -- default, atlantis, andromeda, shusia, maia, espresso
      vim.g.sonokai_style = "default"
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_better_performance = 1
      lvim.colorscheme = "sonokai"
    end
  },
  kanagawa = {
    "rebelot/kanagawa.nvim",
    priority = 1500,
    lazy = false,
    config = function()
      vim.opt.background = background
      require("kanagawa").setup({
        compile = false,
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        background = {
          dark = "wave", -- default dark
          -- dark = "dragon", -- alternative dark
          light = "lotus" -- default light
        },
        overrides = function(colors)
          return {
            ["@lsp.type.comment.c"] = { link = "@comment" },
            ["@lsp.type.comment.cpp"] = { link = "@comment" },
            ["@comment.hint"] = {
              bg = colors.theme.diag.ok,
              fg = colors.theme.ui.fg_reverse,
              bold = true
            },
          }
        end
      })
      lvim.colorscheme = "kanagawa"
    end
  },
  tokyonight = {
    "folke/tokyonight.nvim",
    priority = 1500,
    lazy = false,
    config = function()
      vim.opt.background = background
      require("tokyonight").setup({
        style = "night",
        light_style = "day",          -- from lightest to darkest:
        day_brightness = 0.25,        --  1. storm (default)
        terminal_colors = true,       --  2. moon
        comments = { italic = true }, --  3. night (lunarvim)
        keywords = { italic = true },
        on_highlights = function(hl, c)
          hl.ColorColumn = { bg = c.bg_highlight }
          hl.IndentBlanklineChar = { fg = c.bg_highlight }
          hl.IndentBlanklineSpaceChar = { fg = c.bg_highlight }
          hl.IndentBlanklineSpaceCharBlankline = { fg = c.bg_highlight }
          hl.IndentBlanklineContextChar = { fg = c.dark3 }
          hl.IndentBlanklineContextSpaceChar = { fg = c.dark3 }
        end
      })
      lvim.colorscheme = "tokyonight"
    end
  },
  rose_pine = {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1500,
    lazy = false,
    config = function()
      vim.opt.background = background
      require("rose-pine").setup({
        variant = "auto",      -- auto, main, moon, dawn
        dark_variant = "main", -- main, moon, dawn
        highlight_groups = {
          IndentBlanklineChar = { fg = "overlay" },
          IndentBlanklineSpaceChar = { fg = "overlay" },
          IndentBlanklineSpaceCharBlankline = { fg = "overlay" },
          IndentBlanklineContextChar = { fg = "highlight_med" },
          IndentBlanklineContextSpaceChar = { fg = "highlight_med" },
        }
      })
      lvim.colorscheme = "rose-pine"
    end
  },
  lackluster = {
    "slugbyte/lackluster.nvim",
    priority = 1500,
    lazy = false,
    config = function()
      local lackluster = require("lackluster")
      vim.opt.background = background
      require("nvim-web-devicons").setup({
        color_icons = false,
        override = {
          ["default_icon"] = {
            color = lackluster.color.gray4,
            name = "Default"
          }
        }
      })
      lvim.colorscheme = "lackluster-hack"
      require('lualine').setup({
        options = {
          theme = "lackluster"
        }
      })
    end
  },
  gruber_darker = {
    "hansumane/gruber-darker-neovim",
    priority = 1500,
    lazy = false,
    config = function()
      require("gruber-darker").setup()
      vim.opt.background = background
      lvim.colorscheme = "gruber-darker"
    end
  }
}

local opt_plugins = {
  todo_comments = {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        -- FIX: test
        -- FIXME: test
        -- BUG: test
        -- ISSUE: test
        FIX  = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
        -- WARN: test
        -- WARNING: test
        WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
        -- REV: test
        -- REVIEW: test
        REV  = { icon = " ", color = "review", alt = { "REVIEW" } },
        -- NOTE: test
        -- INFO: test
        NOTE = { icon = " ", color = "note", alt = { "INFO" } },
        -- TODO: test
        TODO = { icon = " ", color = "todo" }
      },
      colors = {
        error   = { "DiagnosticError" },
        warning = { "DiagnosticWarn" },
        review  = { "DiagnosticOk" },
        note    = { "DiagnosticHint" },
        todo    = { "DiagnosticInfo" }
      }
    }
  },
  deadcolumn = {
    "Bekaboo/deadcolumn.nvim",
    priority = 1490,
    lazy = false,
    opts = {
      modes = function()
        return true
      end
    }
  }
}

lvim.plugins = {
  themes.catppuccin,
  opt_plugins.deadcolumn,
  opt_plugins.todo_comments,
  {
    "hansumane/telescope-orgmode.nvim",
    config = function()
      require("telescope").load_extension("orgmode")
      lvim.builtin.which_key.mappings.r = {
        [[<cmd>lua require("telescope").extensions.orgmode.refile_heading()<CR>]],
        "Telescope OrgMode Refile Headings"
      }
      lvim.builtin.which_key.mappings.lh = {
        [[<cmd>lua require("telescope").extensions.orgmode.search_headings()<CR>]],
        "Telescope OrgMode Search Headings"
      }
    end
  },
  {
    "dhananjaylatkar/cscope_maps.nvim",
    commit = "6d3222eca3748c8276578a37373ae939b49df38f",
    opts = {
      prefix = "<C-c>",
      cscope = {
        picker = "telescope"
      }
    }
  },
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    dependencies = { "akinsho/org-bullets.nvim" },
    config = function()
      require("org-bullets").setup()
      require("orgmode").setup({
        org_agenda_files = "~/Others/Documents/orgfiles/**/*",
        org_default_notes_file = "~/Others/Documents/orgfiles/rawid_new.org"
      })
    end
  },
  {
    "rcarriga/nvim-notify",
    priority = 1480,
    lazy = false,
    config = function()
      local notify = require("notify")

      notify.setup({
        render = "compact",
        stages = "static"
      })

      vim.notify = notify
    end
  },
  {
    "junegunn/vim-easy-align",
    priority = 1470,
    lazy = false,
    config = function()
      vim.cmd[[
      xmap ga <Plug>(EasyAlign)
      nmap ga <Plug>(EasyAlign)
      ]]
    end
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  }
}

-- fix for clangd multiple offset encodings warning
local capabilities = vim.lsp.protocol.make_client_capabilities()
local max_threads = #vim.loop.cpu_info() -- require("luv").available_parallelism()
capabilities.offsetEncoding = { "utf-16" }
require("lvim.lsp.manager").setup("clangd", {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "-j=" .. max_threads,
    -- "--malloc-trim",  -- incompatible with MacOS
    "--background-index",
    "--pch-storage=memory"
  }
})
require("lvim.lsp.manager").setup("pyright", {
  settings = {
    python = {
      pythonPath = "python3"
    }
  }
})
require("lvim.lsp.manager").setup("jdtls", {
  cmd = {
    "jdtls",
    "--jvm-arg=-javaagent:" .. vim.fn.stdpath"data" .. "/mason/packages/jdtls/lombok.jar"
  },
})
require("lvim.lsp.manager").setup("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      lens = {
        enable = false
      },
      checkOnSave = {
        command = "clippy"
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
require("lvim.lsp.manager").setup("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "Lua 5.4",
      },
      --[[
      workspace = {
        library = {
          ["~/virtual/definitions"] = true,
          ["~/virtual/vm_mount/usr/share/lua/5.4"] = true,
        }
      }
      --]]
    }
  }
})

require("lvim.lsp.null-ls.formatters").setup({
  {
    command = "black",
    filetypes = { "python" }
  },
  {
    command = "google-java-format",
    filetypes = { "java" }
  },
  {
    command = "clang-format",
    filetypes = { "c", "cpp" }
  }
})

--[[
    to make clipboard work with windows,
    just install the win32yank and put it on path,
    for example,
    C:\bin\win32yank.exe and C:\bin is on path
    https://github.com/equalsraf/win32yank/releases
--]]
