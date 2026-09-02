local gh = require('utils').gh

require('utils').install_with_mason {
  'oxlint',
  'oxfmt',
  'prettierd',
}



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


vim.lsp.config('oxlint', {
  cmd = { 'oxlint', 'lsp' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'vue',
    'svelte',
    'astro',
  },
  settings = {
    fixKind = 'all',
  },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'typescript', 'tsx', 'javascript' })

local conform = require 'conform'




conform.formatters.oxfmt = { command = 'oxfmt', stdin = true }
conform.formatters_by_ft.javascript = { 'prettierd' }
conform.formatters_by_ft.javascriptreact = { 'prettierd' }
conform.formatters_by_ft.typescript = { 'prettierd' }
conform.formatters_by_ft.typescriptreact = { 'prettierd' }

require('lint').linters_by_ft.javascript = { 'oxlint' }
require('lint').linters_by_ft.javascriptreact = { 'oxlint' }
require('lint').linters_by_ft.typescript = { 'oxlint' }
require('lint').linters_by_ft.typescriptreact = { 'oxlint' }

vim.lsp.enable 'ts_ls'
vim.lsp.enable 'oxlint'


PackageManager.add {
  [1] = gh 'Sebastian-Nielsen/better-type-hover',
  event = 'FileType',
  config = function()
    local ok, bth = pcall(require, 'better-type-hover')
    if not ok then return end

    bth.config = bth.config or {}
  end,
}

require('utils').on_file_types({ 'typescript', 'typescriptreact' }, function(ev)
  local ok, bth = pcall(require, 'better-type-hover')
  if not ok then return end

  bth.config = bth.config or {}

  vim.keymap.set('n', '<C-P>', bth.better_type_hover, {
    buffer = ev.buf,
    desc = 'Better type hover',
  })
end)

