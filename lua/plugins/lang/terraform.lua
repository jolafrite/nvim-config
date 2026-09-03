PackageManager.add_with_mason {
  'terraform-ls',
  'tflint',
}

vim.lsp.config('terraformls', {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
})

local conform = require 'conform'
PackageManager.add_formatter({ 'terraform', 'tf', 'terraform-vars' }, 'terraform_fmt')
PackageManager.add_formatter('hcl', 'packer_fmt')

conform.formatters.terraform_fmt = {
  command = 'terraform',
  stdin = true,
  args = { 'fmt', '-' },
}
conform.formatters.packer_fmt = {
  command = 'packer',
  stdin = true,
  args = { 'fmt', '-' },
}

PackageManager.add_linter({ 'terraform', 'tf', 'terraform-vars' }, { 'tflint', 'terraform_validate' })

PackageManager.add_with_treesitter({ 'terraform', 'hcl' })

vim.lsp.enable 'terraformls'
