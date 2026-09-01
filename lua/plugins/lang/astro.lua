-- depends on typescript.lua for the frontmatter script
require('utils').install_with_mason {
  'astro-language-server',
}

vim.lsp.config('astro', {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = { 'astro.config.js', 'astro.config.mjs', 'astro.config.cjs', 'astro.config.ts', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.astro = { 'prettierd' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'astro', 'css' })

vim.lsp.enable 'astro'

-- vim: ts=2 sts=2 sw=2 et
