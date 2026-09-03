PackageManager.add_with_mason {
  'astro-language-server',
}
PackageManager.add_formatter('astro', 'prettierd')

vim.lsp.config('astro', {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = {
    'astro.config.js',
    'astro.config.mjs',
    'astro.config.cjs',
    'astro.config.ts',
    '.git',
  },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'astro', 'css' })

vim.lsp.enable 'astro'
