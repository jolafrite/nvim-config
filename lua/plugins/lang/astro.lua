-- Astro language support (treesitter + LSP config).
--
-- Depends on the typescript/ts_ls config (typescript.lua) for the frontmatter
-- script; astro-language-server handles the rest.
require('utils').install_with_mason {
  'astro-language-server',
}

vim.lsp.config('astro', {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = { 'astro.config.js', 'astro.config.mjs', 'astro.config.cjs', 'astro.config.ts', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.astro = { 'prettier' }

-- Tree-sitter parsers for Astro.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'astro', 'css' })

vim.lsp.enable 'astro'

-- vim: ts=2 sts=2 sw=2 et
