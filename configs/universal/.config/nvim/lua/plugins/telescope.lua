return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = { initial_mode = 'normal' },
      extensions = { file_browser = { initial_mode = 'normal' } },
    }

    require('mappings').add { mods = 'n', map = '<leader>b', opts = { silent = true },
      cmd = ':lua require("telescope.builtin").buffers()<CR>' }

    require('mappings').add { mods = 'n', map = '<leader>se', opts = { silent = true },
      cmd = ':lua require("telescope.builtin").live_grep { ' ..
            '  initial_mode = "insert", ' ..
            '  additional_args = function() return { "--pcre2" } end }<CR>' }
  end
}
