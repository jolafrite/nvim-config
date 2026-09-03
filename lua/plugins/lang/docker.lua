PackageManager.add_with_mason {
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

PackageManager.add_formatter(
  'dockerfile',
  'dockerfmt_fmt',
  function(conform)
    conform.formatters.dockerfmt_fmt = {
      command = 'dockerfmt',
      stdin = true,
      args = { '-' },
    }
  end
)

PackageManager.add_linter('dockerfile', 'hadolint')

PackageManager.add_with_treesitter { 'dockerfile' }

vim.lsp.enable 'dockerls'
vim.lsp.enable 'docker_compose_language_service'
