-- formatting stays owned by prettier; oxfmt is defined here for
-- per-buffer opt-in only (not attached).
PackageManager.add({
  name = 'lang.oxc',
  filetype = {
    'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
    'json', 'jsonc', 'vue', 'svelte', 'astro',
  },
  config = function()

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
  end,
})

-- vim: ts=2 sts=2 sw=2 et
