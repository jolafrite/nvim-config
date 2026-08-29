-- SQL language support (treesitter + LSP config, dadbod databases).
local gh = require('utils').gh

local sql_ft = { 'sql', 'mysql', 'plsql' }

-- Disable the default `sql_completion` plugin to stay compatible with
-- blink.cmp's omnifunc while still showing syntax keywords.
vim.g.omni_sql_default_compl_type = 'syntax'
vim.g.loaded_sql_completion = true

vim.pack.add {
  gh 'tpope/vim-dadbod',
  gh 'kristijanhusak/vim-dadbod-ui',
  gh 'kristijanhusak/vim-dadbod-completion',
}

vim.keymap.set('n', '<leader>D', '<cmd>DBUIToggle<CR>', { desc = 'Toggle DBUI' })

require('utils').install_with_mason {
  'sqls',
  'sqlfluff',
}

vim.lsp.config('sqls', {
  cmd = { 'sqls' },
  filetypes = sql_ft,
  root_markers = { 'config.yml' },
  settings = {},
})

-- blink.cmp: the dadbod completion provider is registered in blink.lua
-- (the single source of truth for the blink config).

local conform = require 'conform'
conform.formatters.sqlfluff = {
  args = { 'format', '--dialect=ansi', '-' },
}
for _, ft in ipairs(sql_ft) do
  conform.formatters_by_ft[ft] = { 'sqlfluff' }
end

local lint = require 'lint'
for _, ft in ipairs(sql_ft) do
  lint.linters_by_ft[ft] = { 'sqlfluff' }
end

-- Tree-sitter parser for SQL.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'sql' })

vim.lsp.enable 'sqls'

-- vim: ts=2 sts=2 sw=2 et
