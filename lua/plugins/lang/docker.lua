-- Docker language support (treesitter + LSP config).
require('utils').install_with_mason {
  'docker-language-server',
  'docker-compose-language-service',
  'dockerfmt',
  'hadolint',
}

vim.lsp.config('dockerls', {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = { 'dockerfile' },
  root_markers = { 'Dockerfile', 'Containerfile' },
})

vim.lsp.config('docker_compose_language_service', {
  cmd = { 'docker-compose-langserver', '--stdio' },
  filetypes = { 'yaml.docker-compose' },
  root_markers = { 'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml' },
})

local conform = require 'conform'
conform.formatters.dockerfmt_fmt = {
  command = 'dockerfmt',
  stdin = true,
  args = { '-' },
}
conform.formatters_by_ft.dockerfile = { 'dockerfmt_fmt' }

require('lint').linters_by_ft.dockerfile = { 'hadolint' }

-- Tree-sitter parser for Dockerfiles.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'dockerfile' })

vim.lsp.enable 'dockerls'
vim.lsp.enable 'docker_compose_language_service'

-- vim: ts=2 sts=2 sw=2 et
