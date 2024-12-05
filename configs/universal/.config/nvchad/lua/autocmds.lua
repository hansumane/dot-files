local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
  callback = function()
    vim.cmd[[
      command! SN :lua SetNumber(true)
      command! USN :lua SetNumber(false)
      command! S2 :lua SetIndent({ spaces = 2 })
      command! S4 :lua SetIndent({ spaces = 4 })
      command! S8 :lua SetIndent({ spaces = 8 })
      command! T2 :lua SetIndent({ spaces = 2, tabs = 2, noexpand = true })
      command! T4 :lua SetIndent({ spaces = 4, tabs = 4, noexpand = true })
      command! T8 :lua SetIndent({ spaces = 8, tabs = 8, noexpand = true })
      command! M2 :lua SetIndent({ spaces = 2, tabs = 4, noexpand = true })
      command! M4 :lua SetIndent({ spaces = 4, tabs = 8, noexpand = true })
      command! MG :lua SetIndent({ spaces = 2, tabs = 8, noexpand = true })
      Cscope db add /home/kid/linux/linux-6.11.9/cscope.out:/home/kid/linux/linux-6.11.9
    ]]
    SetNumber(true)
  end
})

autocmd("QuitPre", {
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
})
