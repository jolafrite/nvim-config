local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'Olical/conjure',
  dependencies = {
    gh 'julienvincent/nvim-paredit',
    gh 'm00qek/baleia.nvim',
  },
  filetype = { 'clojure' },
  config = function()
    vim.g['conjure#mapping#doc_word'] = 'K'
    vim.g['conjure#mapping#def_word'] = 'gd'

    PackageManager.add_with_treesitter({ 'clojure' })

    require('utils').on_file_types({ 'clojure', 'edn' }, function()
      pcall(function() require('conjure.main').main() end)
      pcall(function() require('nvim-paredit').setup {} end)
    end)

    local baleia_ok, baleia = pcall(require, 'baleia')
    if baleia_ok then
      vim.g.conjure_baleia = baleia.setup { line_starts_at = 3 }

      vim.api.nvim_create_user_command('BaleiaColorize', function() vim.g.conjure_baleia.once(vim.api.nvim_get_current_buf()) end, { bang = true })

      vim.api.nvim_create_user_command('BaleiaLogs', vim.g.conjure_baleia.logger.show, { bang = true })
    end
  end,
}
