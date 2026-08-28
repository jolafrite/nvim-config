vim.diagnostic.config {
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = '󰗖 ',
      [vim.diagnostic.severity.HINT] = '󰘥 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
    },
  },
}

vim.keymap.set('n', '<leader>ue', '<cmd>LspLensToggle<cr>', { desc = 'Toggle Lsp Lens' })

-- vim: ts=2 sts=2 sw=2 et
