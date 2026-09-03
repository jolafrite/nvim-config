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

PackageManager.add_with_treesitter { 'xml' }

vim.lsp.enable 'lemminx'
