---@brief
---
--- https://github.com/EffortlessMetrics/perl-lsp

---@type vim.lsp.Config
return {
  cmd = {
    'perl-lsp',
    '--stdio'
  },
  filetypes = { 'perl' },
  root_markers = { '.git' }
}
