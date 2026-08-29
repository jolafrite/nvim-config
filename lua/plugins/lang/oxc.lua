-- formatting stays owned by prettier; oxfmt is defined here for
-- per-buffer opt-in only (not attached).
require('utils').install_with_mason {
  'oxlint',
  'oxfmt',
}

local oxc_filetypes = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'json',
  'jsonc',
  'vue',
  'svelte',
  'astro',
}

vim.lsp.config('oxlint', {
  cmd = { 'oxlint', 'lsp' },
  filetypes = oxc_filetypes,
  settings = {
    fixKind = 'all',
  },
})

local conform = require 'conform'
conform.formatters.oxfmt = { command = 'oxfmt', stdin = true }

vim.lsp.enable 'oxlint'

-- vim: ts=2 sts=2 sw=2 et
