local gh = require('utils').gh

Manager.add({
  [1] = gh 'ray-x/go.nvim',
  dependencies = {
    gh 'fredrikaverpil/neotest-golang'
  },
  filetype = {'go', 'gomod', 'gowork', 'gotmpl'},
  config = function()

require('utils').install_with_mason {
  'gopls',
  'goimports',
  'gofumpt',
  'golangci-lint',
  'gomodifytags',
  'impl',
}
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

pcall(function()
  require('neotest').setup {
    adapters = {
      ['neotest-golang'] = {},
    },
  }
end)

vim.keymap.set({ 'n', 'x' }, '<localleader>gj', function() vim.cmd('GoIfErr ' .. vim.fn.expand '%:p') end, { desc = 'Add if err' })
vim.keymap.set({ 'n', 'x' }, '<localleader>gt', function() require('go').test.run_test_near() end, { desc = 'Run test' })
vim.keymap.set({ 'n', 'x' }, '<localleader>gT', function() require('go').test.run_tests() end, { desc = 'Run tests' })
vim.keymap.set({ 'n', 'x' }, '<localleader>gf', function() require('go').fmt.run('gofumpt', { async = true }) end, { desc = 'Format (gofumpt)' })
vim.keymap.set({ 'n', 'x' }, '<localleader>gi', function() require('go').fmt.run('goimports', { async = true }) end, { desc = 'Fix imports' })
vim.keymap.set({ 'n', 'x' }, '<localleader>ge', function() require('go').test.show_err() end, { desc = 'Test error output' })

-- vim: ts=2 sts=2 sw=2 et
  end,
})

-- vim: ts=2 sts=2 sw=2 et
