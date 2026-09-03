PackageManager.add_with_mason {
  'yaml-language-server',
}

vim.lsp.config('yamlls', {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  before_init = function(_, new_config)
    local schemastore_ok, schemastore = pcall(require, 'schemastore')
    new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
    if schemastore_ok then new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas, schemastore.yaml.schemas()) end
  end,
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = { enable = true },
      validate = true,
      schemaStore = {
        enable = false,
        url = '',
      },
    },
  },
})

PackageManager.add_with_treesitter { 'yaml' }

vim.lsp.enable 'yamlls'
