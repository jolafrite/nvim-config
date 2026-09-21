PackageManager.add_with_mason {
  'docker-language-server',
  'dockerfmt',
  'hadolint',
}

vim.lsp.config('dockerls', {
  cmd = { 'docker-language-server', 'start', '--stdio' },
  filetypes = { 'dockerfile', 'yaml.docker-compose' },
  get_language_id = function(_, ftype)
    if ftype == 'yaml.docker-compose' or ftype:lower():find 'ya?ml' then
      return 'dockercompose'
    else
      return ftype
    end
  end,
  root_markers = {
    'Dockerfile',
    'docker-compose.yaml',
    'docker-compose.yml',
    'compose.yaml',
    'compose.yml',
    'docker-bake.json',
    'docker-bake.hcl',
    'docker-bake.override.json',
    'docker-bake.override.hcl',
  },
})

PackageManager.add_formatter({ 'dockerfile', 'yaml.docker-compose' }, 'dockerfmt', function(conform)
  conform.formatters.dockerfmt = {
    command = 'dockerfmt',
    timeout_ms = 10000,
  }
end)

PackageManager.add_linter('dockerfile', 'hadolint')

PackageManager.add_with_treesitter { 'dockerfile' }

vim.lsp.enable 'dockerls'
