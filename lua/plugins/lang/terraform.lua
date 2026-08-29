-- Terraform language support (treesitter + LSP config).
require('utils').install_with_mason {
  'terraform-ls',
  'tflint',
}

vim.lsp.config('terraformls', {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.terraform = { 'terraform_fmt' }
conform.formatters_by_ft.tf = { 'terraform_fmt' }
conform.formatters_by_ft['terraform-vars'] = { 'terraform_fmt' }
conform.formatters_by_ft.hcl = { 'terraform_fmt' }

conform.formatters.terraform_fmt = {
  command = 'terraform',
  stdin = true,
  args = { 'fmt', '-' },
}

local lint = require 'lint'
lint.linters_by_ft.terraform = { 'tflint' }
lint.linters_by_ft.tf = { 'tflint' }
lint.linters_by_ft['terraform-vars'] = { 'tflint' }

vim.lsp.enable 'terraformls'

-- vim: ts=2 sts=2 sw=2 et
