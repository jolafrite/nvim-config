local gh = require('utils').gh

PackageManager.add({
  [1] = gh 'Olical/conjure',
  dependencies = {
    gh 'julienvincent/nvim-paredit',
    gh 'm00qek/baleia.nvim'
  },
  filetype = {'clojure'},
  config = function()

-- Prefer LSP for jump-to-definition and symbol-doc, and use conjure
-- alternatives with <localleader>K and <localleader>gd.
vim.g['conjure#mapping#doc_word'] = 'K'
vim.g['conjure#mapping#def_word'] = 'gd'

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'clojure' })

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

-- vim: ts=2 sts=2 sw=2 et
  end,
})

-- vim: ts=2 sts=2 sw=2 et
