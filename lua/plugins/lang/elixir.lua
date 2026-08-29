-- Elixir language support (treesitter + LSP config).
require('utils').install_with_mason {
  'elixir-ls',
}

vim.lsp.config('elixirls', {
  cmd = { 'elixir-ls' },
  filetypes = { 'elixir', 'eelixir', 'heex', 'surface', 'livebook' },
  root_markers = { 'mix.exs', '.git' },
})

local lint = require 'lint'
lint.linters_by_ft.elixir = { 'credo' }
-- Only run credo when the project opts in via `.credo.exs`.
lint.linters.credo = vim.tbl_deep_extend('force', lint.linters.credo or {}, {
  condition = function(ctx) return vim.fs.find({ '.credo.exs' }, { path = ctx.filename, upward = true })[1] ~= nil end,
})

-- Tree-sitter parsers for Elixir (livebook uses the markdown parser).
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'elixir', 'heex', 'eex' })
vim.treesitter.language.register('markdown', 'livebook')

vim.lsp.enable 'elixirls'

-- vim: ts=2 sts=2 sw=2 et
