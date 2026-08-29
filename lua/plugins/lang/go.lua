-- Go language support.
--
-- go.nvim is installed with lsp_cfg = false so it does NOT register a gopls
-- client on its own. We register gopls here explicitly (mirroring the LazyVim
-- default settings: gofumpt, codelenses, inlay hints, staticcheck) and then
-- let go.nvim handle the formatting/lint/test keymaps.
--
-- The gopls semanticTokensProvider workaround below is needed because gopls
-- does not advertise semanticTokensProvider in serverCapabilities; without
-- it, semantic highlighting silently degrades to nothing. See:
-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = {
    'go',
    'gomod',
    'gowork',
    'gotmpl',
  },
  root_markers = { 'go.work', 'go.mod' },
  init_options = {
    semanticTokens = true,
  },
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = {
        '-.git',
        '-.vscode',
        '-.idea',
        '-.vscode-test',
        '-node_modules',
      },
    },
  },
})

-- Workaround for gopls not supporting semanticTokensProvider.
require('snacks').util.lsp.on({ name = 'gopls' }, function(_, client)
  if client.config and client.config.init_options and client.config.init_options.semanticTokens and not client.server_capabilities.semanticTokensProvider then
    local semantic = client.config.capabilities.textDocument.semanticTokens
    client.server_capabilities.semanticTokensProvider = {
      full = true,
      legend = {
        tokenTypes = semantic.tokenTypes,
        tokenModifiers = semantic.tokenModifiers,
      },
      range = true,
    }
  end
end)

vim.lsp.enable 'gopls'

local gh = require('utils').gh

vim.pack.add {
  gh 'ray-x/go.nvim',
}

require('utils').install_with_mason {
  'gopls',
  'goimports',
  'gofumpt',
  'golangci-lint',
  'gomodifytags',
  'impl',
}
-- Tree-sitter parsers for Go (mirrors the mason install pattern above).
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'go', 'gomod', 'gowork', 'gosum' })

local go = require 'go'

go.setup {
  lsp_cfg = false,
  gofmt = 'gofumpt',
  goimports = 'goimports',
  gofumpt = true,
  golangci_lint = { default = 'standard' },
  keymaps = false,
}

require('conform').formatters.gofumpt = {
  command = 'gofumpt',
  stdin = true,
}
require('conform').formatters.goimports = {
  command = 'goimports',
  stdin = true,
  args = { '-local', vim.fn.getcwd() },
}
require('conform').formatters_by_ft.go = { 'goimports', 'gofumpt', 'gocondense' }

require('lint').linters_by_ft.go = { 'golangcilint' }

vim.keymap.set({ 'n', 'x' }, '<localleader>gj', function() vim.cmd('GoIfErr ' .. vim.fn.expand '%:p') end, { desc = 'Add if err' })
vim.keymap.set({ 'n', 'x' }, '<localleader>gt', function() require('go').test.run_test_near() end, { desc = 'Run test' })
vim.keymap.set({ 'n', 'x' }, '<localleader>gT', function() require('go').test.run_tests() end, { desc = 'Run tests' })
vim.keymap.set({ 'n', 'x' }, '<localleader>gf', function() require('go').fmt.run('gofumpt', { async = true }) end, { desc = 'Format (gofumpt)' })
vim.keymap.set({ 'n', 'x' }, '<localleader>gi', function() require('go').fmt.run('goimports', { async = true }) end, { desc = 'Fix imports' })
vim.keymap.set({ 'n', 'x' }, '<localleader>ge', function() require('go').test.show_err() end, { desc = 'Test error output' })

-- vim: ts=2 sts=2 sw=2 et
