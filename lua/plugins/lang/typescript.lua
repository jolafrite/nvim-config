-- Typescript language support.
--
-- Uses merge-form `vim.lsp.config("ts_ls", {...})` so that the base
-- `cmd`/`filetypes` set in `lsp.lua` are preserved (assignment form
-- `vim.lsp.config.ts_ls = {}` would replace and discard them).
--
-- `typescript-language-server` is unusual in two ways vs. other mason servers:
--   1. It REQUIRES `--stdio` to be passed explicitly in `cmd`. Every other
--      server here (gopls, lua-language-server, ...) is invoked with no
--      args; omitting `--stdio` makes this binary refuse to start with
--      `error: required option '--stdio' not specified`.
--   2. `filetypes` must be a table, not a function -- this Neovim's
--      `vim/lsp.lua:479` rejects a function value for `filetypes`.
require('utils').install_with_mason {
  'oxlint',
  'prettier',
}

-- ts_ls mirrors these settings for javascript files as well.
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
-- Tree-sitter parsers for TS/JS.
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

-- vim: ts=2 sts=2 sw=2 et
