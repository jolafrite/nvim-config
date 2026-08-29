-- Tailwind CSS language support (treesitter + LSP config).
require('utils').install_with_mason {
  'tailwindcss-language-server',
  'prettier',
  'stylelint',
}

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
    -- note: markdown is intentionally excluded (mirrors the LazyVim extra);
    -- tailwind completions/formatting in markdown docs are noisy.
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

local conform = require 'conform'
conform.formatters.prettier = {
  command = 'prettier',
  stdin = true,
}
conform.formatters_by_ft.html = { 'prettier' }
conform.formatters_by_ft.css = { 'prettier' }
conform.formatters_by_ft.less = { 'prettier' }
conform.formatters_by_ft.sass = { 'prettier' }
conform.formatters_by_ft.scss = { 'prettier' }
conform.formatters_by_ft.stylus = { 'prettier' }

require('lint').linters_by_ft.css = { 'stylelint' }
require('lint').linters_by_ft.less = { 'stylelint' }
require('lint').linters_by_ft.sass = { 'stylelint' }
require('lint').linters_by_ft.scss = { 'stylelint' }
require('lint').linters_by_ft.stylus = { 'stylelint' }

vim.lsp.enable 'tailwindcss'

-- vim: ts=2 sts=2 sw=2 et
