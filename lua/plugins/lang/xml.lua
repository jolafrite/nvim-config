PackageManager.add_with_mason {
  'xmlformatter',
  'lemminx',
}
PackageManager.add_formatter('xml', 'xmlformatter')

vim.lsp.config('lemminx', {
  cmd = { 'lemminx' },
  filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
  root_markers = { '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'xml' })

vim.lsp.enable 'lemminx'
