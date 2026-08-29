-- Biome (all-in-one JS/TS linter+formatter) language support.
--
-- The biome LSP is registered alongside the JS/TS servers. Formatting is
-- still owned by prettier (see typescript.lua and friends); the
-- `biome-check` conform formatter below is only *defined*, not attached, so
-- it can be opted into per-buffer without double-formatting conflicts.
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
