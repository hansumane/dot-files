-- LunarVim (lvim) config

vim.opt.mouse = 'nv'
vim.opt.scrolloff = 3
vim.g.c_syntax_for_h = true
vim.cmd[[set iskeyword-=_]]

vim.opt.keymap = 'russian-jcukenwin'
vim.opt.iminsert = 0
vim.opt.imsearch = 0

lvim.builtin.terminal.open_mapping = '<C-t>'
lvim.keys.insert_mode['<C-\\>'] = '<C-6>'
lvim.keys.insert_mode['<C-k>'] = '<C-v><C-i>'
lvim.keys.normal_mode['<S-h>'] = '<cmd>BufferLineCyclePrev<cr>'
lvim.keys.normal_mode['<S-l>'] = '<cmd>BufferLineCycleNext<cr>'
lvim.keys.normal_mode['<S-n>'] = '<cmd>BufferLineMovePrev<cr>'
lvim.keys.normal_mode['<S-m>'] = '<cmd>BufferLineMoveNext<cr>'
lvim.lsp.buffer_mappings.normal_mode['gr'] = {
  [[<cmd>lua require'telescope.builtin'.lsp_references()<cr>]],
  'References',
}

function SetNumber(toggle)
  vim.opt.number = toggle and true or false
  vim.opt.colorcolumn = toggle and {91, 140} or {}
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

SetNumber(true)

lvim.format_on_save.enabled = false
lvim.builtin.nvimtree.setup.view.adaptive_size = true

lvim.builtin.treesitter.sync_install = false
lvim.builtin.treesitter.auto_install = false
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ensure_installed = {
  'lua', 'luadoc', 'vim', 'vimdoc', 'bash',
  'c', 'cpp', 'python', 'rust',
  'make', 'cmake', 'json', 'toml', 'yang',
  'gitcommit', 'gitignore'
}

lvim.lsp.automatic_servers_installation = false
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.installer.setup.ensure_installed = {
  'lua_ls',
  'clangd',
  'pyright',
  'rust_analyzer',
}

local components = require'lvim.core.lualine.components'
lvim.builtin.lualine.sections.lualine_a = {"mode"}
lvim.builtin.lualine.sections.lualine_x = {
  components.lsp,
  components.filetype,
  function ()
    if vim.opt.iminsert:get() ~= 0 then
      return 'RU'
    else
      return 'EN'
    end
  end,
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

lvim.plugins = {
  {
    'catppuccin/nvim',
    name = "catppuccin",
    priority = 1500,
    config = function()
      vim.opt.background = 'dark'
      require'catppuccin'.setup{flavour = 'mocha'}
      lvim.colorscheme = 'catppuccin'
    end
  },
  {
    'folke/todo-comments.nvim',
    opts = {},
  }
}

lvim.autocommands = {
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
