local gh = require('utils').gh

require('utils').install_with_mason {
  'oxlint',
  'prettier',
}

-- `typescript-language-server` refuses to start without an explicit `--stdio`.
-- Inlay-hint settings are mirrored to javascript too (js_ts_settings).
local js_ts_settings = {
  typescript = {
    inlayHints = {
      enumMemberValues = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      parameterNames = { enabled = 'literals' },
      parameterTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      variableTypes = { enabled = false },
    },
  },
  javascript = {
    inlayHints = {
      enumMemberValues = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      parameterNames = { enabled = 'literals' },
      parameterTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      variableTypes = { enabled = false },
    },
  },
}

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_markers = {
    'tsconfig.json',
    'package.json',
    'jsconfig.json',
    '.git',
  },
  settings = js_ts_settings,
})
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'typescript', 'tsx', 'javascript' })

local conform = require 'conform'
conform.formatters.prettier = {
  command = 'prettier',
  stdin = true,
}
conform.formatters_by_ft.javascript = { 'prettier' }
conform.formatters_by_ft.javascriptreact = { 'prettier' }
conform.formatters_by_ft.typescript = { 'prettier' }
conform.formatters_by_ft.typescriptreact = { 'prettier' }

require('lint').linters_by_ft.javascript = { 'oxlint' }
require('lint').linters_by_ft.javascriptreact = { 'oxlint' }
require('lint').linters_by_ft.typescript = { 'oxlint' }
require('lint').linters_by_ft.typescriptreact = { 'oxlint' }

vim.lsp.enable 'ts_ls'

require('utils').on_file_types({ 'typescript', 'typescriptreact' }, function(ev)
  vim.pack.add {
    gh 'Sebastian-Nielsen/better-type-hover',
  }

  local ok, bth = pcall(require, 'better-type-hover')
  if not ok then return end

  bth.config = bth.config or {}

  vim.keymap.set('n', '<C-P>', bth.better_type_hover, {
    buffer = ev.buf,
    desc = 'Better type hover',
  })
end)

-- vim: ts=2 sts=2 sw=2 et
