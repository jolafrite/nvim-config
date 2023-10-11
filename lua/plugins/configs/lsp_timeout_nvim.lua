vim.g['lsp-timeout-config'] = {
  stopTimeout = 1000 * 60 * 5, -- wait ms before stopping all LSP servers
  startTimeout = 1,
  silent = true, -- true to suppress notifications
}
