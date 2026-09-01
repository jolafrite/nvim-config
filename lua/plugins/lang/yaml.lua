require('utils').install_with_mason {
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
    -- required here (not top-level) because SchemaStore.nvim is loaded
    -- lazily via the json/yaml filetype trigger in plugins/schemastore.lua
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
        enable = false, -- SchemaStore.nvim supplies schemas instead
        url = '', -- avoids a TypeError in yamlls
      },
    },
  },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'yaml' })

vim.lsp.enable 'yamlls'

-- vim: ts=2 sts=2 sw=2 et
