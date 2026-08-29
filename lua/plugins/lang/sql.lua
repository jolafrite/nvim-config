local gh = require('utils').gh

local sql_ft = { 'sql', 'mysql', 'plsql' }

-- Disable the built-in sql_completion so blink.cmp's omnifunc keeps working.
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

-- The dadbod completion source is registered in blink.lua.
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

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'sql' })

vim.lsp.enable 'sqls'

-- vim: ts=2 sts=2 sw=2 et
