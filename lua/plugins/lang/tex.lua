local gh = require('utils').gh

PackageManager.add({
  [1] = gh 'lervag/vimtex',
  filetype = {'tex', 'plaintex', 'bib'},
  config = function()

require('utils').install_with_mason {
  'texlab',
}



vim.g.vimtex_compiler_method = 'tectonic'
vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } }
vim.g.vimtex_quickfix_method = vim.fn.executable 'pplatex' == 1 and 'pplatex' or 'latexlog'

vim.lsp.config('texlab', {
  cmd = { 'texlab' },
  filetypes = { 'tex', 'plaintex', 'bib' },
  root_markers = { '.latexmkrc', 'texlabroot', 'Tectonic.toml' },
})

vim.lsp.enable 'texlab'


local TS = require 'nvim-treesitter'
pcall(TS.install, { 'bibtex', 'latex' })


  end,
})

