-- Oxc (oxlint LSP + oxfmt formatter) language support.
--
-- The oxlint LSP is registered alongside the JS/TS servers. Formatting is
-- still owned by prettier (see typescript.lua and friends); the `oxfmt`
-- conform formatter below is only *defined*, not attached, so it can be
-- opted into per-buffer without double-formatting conflicts.
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
