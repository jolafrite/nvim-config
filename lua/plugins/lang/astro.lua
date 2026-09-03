PackageManager.add_with_mason {
  'astro-language-server',
}
PackageManager.add_formatter('astro', 'prettierd')

PackageManager.add_snippets 'astro'

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

PackageManager.add_with_treesitter { 'astro', 'css' }

vim.lsp.enable 'astro'
