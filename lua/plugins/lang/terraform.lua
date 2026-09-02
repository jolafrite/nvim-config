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
conform.formatters_by_ft.hcl = { 'packer_fmt' }

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

local lint = require 'lint'
lint.linters_by_ft.terraform = { 'tflint', 'terraform_validate' }
lint.linters_by_ft.tf = { 'tflint', 'terraform_validate' }
lint.linters_by_ft['terraform-vars'] = { 'tflint', 'terraform_validate' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'terraform', 'hcl' })

vim.lsp.enable 'terraformls'

