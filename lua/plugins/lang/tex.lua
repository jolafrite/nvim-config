local gh = require('utils').gh

PackageManager.add({
  [1] = gh 'lervag/vimtex',
  filetype = {'tex', 'plaintex', 'bib'},
  config = function()

require('utils').install_with_mason {
  'texlab',
}

-- vimtex is not lazy-loaded: lazy-loading breaks inverse search.
-- tectonic is installed and latexmk is not, so use the tectonic compiler.
vim.g.vimtex_compiler_method = 'tectonic'
vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } } -- disable `K` as it conflicts with LSP hover
vim.g.vimtex_quickfix_method = vim.fn.executable 'pplatex' == 1 and 'pplatex' or 'latexlog'

vim.lsp.config('texlab', {
  cmd = { 'texlab' },
  filetypes = { 'tex', 'plaintex', 'bib' },
  root_markers = { '.latexmkrc', 'texlabroot', 'Tectonic.toml' },
})

vim.lsp.enable 'texlab'

-- latex highlighting is left to vimtex.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'bibtex', 'latex' })

-- vim: ts=2 sts=2 sw=2 et
  end,
})

-- vim: ts=2 sts=2 sw=2 et
