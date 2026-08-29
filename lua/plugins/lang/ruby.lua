-- Ruby language support (treesitter + LSP config).
--
-- LSP for Ruby. Set `vim.g.lazyvim_ruby_lsp = "solargraph"` (in options.lua)
-- to use solargraph instead of ruby_lsp. Formatting is done with rubocop by
-- default; set `vim.g.lazyvim_ruby_formatter = "standardrb"` to switch.
local lsp = vim.g.lazyvim_ruby_lsp or 'ruby_lsp'
local formatter = vim.g.lazyvim_ruby_formatter or 'rubocop'

require('utils').install_with_mason {
  lsp,
  'rubocop',
  'standardrb',
  'erb-formatter',
  'erb-lint',
}

if lsp == 'ruby_lsp' then
  vim.lsp.config('ruby_lsp', {
    cmd = { 'ruby-lsp' },
    filetypes = { 'ruby' },
    root_markers = { 'Gemfile', 'Rakefile', '.git' },
  })
  vim.lsp.enable 'ruby_lsp'
else
  vim.lsp.config('solargraph', {
    cmd = { 'solargraph', 'stdio' },
    filetypes = { 'ruby' },
    root_markers = { 'Gemfile', 'Rakefile', '.git' },
  })
  vim.lsp.enable 'solargraph'
end

-- If Solargraph is the LSP, rubocop diagnostics would be duplicated (it
-- already runs rubocop internally), so we only enable the rubocop LSP
-- alongside ruby_lsp.
if formatter == 'rubocop' and lsp ~= 'solargraph' then
  vim.lsp.config('rubocop', {
    cmd = { 'rubocop', '--lsp' },
    filetypes = { 'ruby' },
  })
  vim.lsp.enable 'rubocop'
end

-- Tree-sitter parser for Ruby.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'ruby' })

local conform = require 'conform'
conform.formatters_by_ft.ruby = { formatter }
conform.formatters_by_ft.eruby = { 'erb_format' }

-- vim: ts=2 sts=2 sw=2 et
