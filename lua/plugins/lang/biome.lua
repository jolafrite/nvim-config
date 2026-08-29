-- formatting stays owned by prettier; biome-check is defined here for
-- per-buffer opt-in only (not attached).
require('utils').install_with_mason {
  'biome',
}

local biome_filetypes = {
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

vim.lsp.config('biome', {
  cmd = { 'biome', 'lsp-proxy' },
  filetypes = biome_filetypes,
})

local conform = require 'conform'
conform.formatters['biome-check'] = {
  require_cwd = true,
}

vim.lsp.enable 'biome'

-- vim: ts=2 sts=2 sw=2 et
