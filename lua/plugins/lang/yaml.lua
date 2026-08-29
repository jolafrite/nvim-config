-- YAML language support (treesitter + LSP config + SchemaStore schemas).
require('utils').install_with_mason {
  'yaml-language-server',
}

local schemastore_ok, schemastore = pcall(require, 'schemastore')

vim.lsp.config('yamlls', {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  -- Required for yamlls to understand line folding.
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  -- Lazy-load schemastore when needed.
  before_init = function(_, new_config)
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
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
    },
  },
})

-- Tree-sitter parser for YAML.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'yaml' })

vim.lsp.enable 'yamlls'

-- vim: ts=2 sts=2 sw=2 et
