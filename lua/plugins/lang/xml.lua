require('utils').install_with_mason {
  'xmlformatter',
  'lemminx',
}

vim.lsp.config('lemminx', {
  cmd = { 'lemminx' },
  filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
  root_markers = { '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'xml' })

local conform = require 'conform'
conform.formatters_by_ft.xml = { 'xmlformatter' }

vim.lsp.enable 'lemminx'

