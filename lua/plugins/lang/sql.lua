local gh = require('utils').gh

local sql_ft = { 'sql' }

PackageManager.add {
  [1] = gh 'tpope/vim-dadbod',
  dependencies = {
    gh 'kristijanhusak/vim-dadbod-ui',
    gh 'kristijanhusak/vim-dadbod-completion',
  },
  filetype = { 'sql' },
  config = function()
    vim.keymap.set('n', '<leader>D', '<cmd>DBUIToggle<CR>',
      { desc = 'Toggle DBUI' })

    PackageManager.add_with_mason {
      'sqls',
      'sqlfluff',
    }

    vim.lsp.config('sqls', {
      cmd = { 'sqls' },
      filetypes = sql_ft,
      root_markers = { 'config.yml' },
      settings = {},
    })

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

    PackageManager.add_with_treesitter({ 'sql' })

    vim.lsp.enable 'sqls'
  end,
}
