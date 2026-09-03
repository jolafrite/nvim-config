PackageManager.add_with_mason {
  'json-lsp',
  'fixjson',
  'jsonlint',
}

vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc', 'json5' },
  root_markers = { '.git' },
  before_init = function(_, new_config)
    local schemastore_ok, schemastore = pcall(require, 'schemastore')
    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
    if schemastore_ok then vim.list_extend(new_config.settings.json.schemas, schemastore.json.schemas()) end
  end,
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
    },
  },
})

local conform = require 'conform'
conform.formatters.fixjson = {
  command = 'fixjson',
  stdin = true,
}
PackageManager.add_formatter({ 'json', 'jsonc' }, { 'prettierd', 'fixjson' })

PackageManager.add_linter({ 'json', 'jsonc' }, 'jsonlint')

vim.lsp.enable 'jsonls'

PackageManager.add_with_treesitter({ 'json', 'json5' })
