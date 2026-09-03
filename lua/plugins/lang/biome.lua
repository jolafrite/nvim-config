PackageManager.add_with_mason {
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
