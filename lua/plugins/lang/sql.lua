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

        PackageManager.add_formatter(sql_ft, 'sqlfluff', function(conform)
          conform.formatters.sqlfluff = {
            args = { 'format', '--dialect=ansi', '-' },
          }
        end)

    PackageManager.add_linter(sql_ft, 'sqlfluff')

    PackageManager.add_with_treesitter({ 'sql' })

    vim.lsp.enable 'sqls'
  end,
}
