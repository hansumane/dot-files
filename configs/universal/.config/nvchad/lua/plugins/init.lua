return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "dhananjaylatkar/cscope_maps.nvim",
    cmd = "Cscope",
    commit = "79452ca6b9bac87ff51ea543bb649c33bfe9e157",
    -- commit = "6d3222eca3748c8276578a37373ae939b49df38f",
    opts = {
      prefix = "<C-c>",
      cscope = { picker = "telescope" },
    },
  },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      local notify = require("notify")

      notify.setup({
        render = "compact",
        stages = "static",
      })

      vim.notify = notify
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    event = "User FilePost",
    -- event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        -- FIX
        -- FIX: test
        -- FIXME: test
        -- BUG: test
        -- ISSUE: test
        FIX  = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
        -- WARN
        -- WARN: test
        -- WARNING: test
        WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
        -- REV: test
        -- REVIEW: test
        REV  = { icon = " ", color = "review", alt = { "REVIEW" } },
        -- NOTE
        -- NOTE: test
        -- INFO: test
        NOTE = { icon = " ", color = "note", alt = { "INFO" } },
        -- TODO
        -- TODO: test
        TODO = { icon = " ", color = "todo" },
      },
      colors = {
        error   = { "DiagnosticError" },
        warning = { "DiagnosticWarn" },
        review  = { "DiagnosticOk" },
        note    = { "DiagnosticHint" },
        todo    = { "DiagnosticInfo" },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ignore_install = { "make", "tmux" },
      ensure_installed = {
        "c", "cpp", "bash", "java", "lua", "python", "rust", "php",
        "vim", "vimdoc", "org", "comment", "markdown", "markdown_inline",
        "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
      },
    },
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require "configs.lspconfig"
  --   end,
  -- },
}
