PackageManager.add_with_mason {
  'tailwindcss-language-server',
  'prettierd',
  'stylelint',
}
PackageManager.add_formatter({ 'html', 'css', 'less', 'sass', 'scss', 'stylus' }, 'prettierd')
PackageManager.add_linter({ 'css', 'less', 'sass', 'scss', 'stylus' }, 'stylelint')

vim.lsp.config('tailwindcss', {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'html',
    'css',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'svelte',
    'astro',
    'templ',
    'php',
    'blade',
    'mdx',
  },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        elixir = 'html-eex',
        eelixir = 'html-eex',
        heex = 'html-eex',
      },
    },
  },
})

vim.lsp.enable 'tailwindcss'
