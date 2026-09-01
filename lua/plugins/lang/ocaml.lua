PackageManager.add({
  name = 'lang.ocaml',
  filetype = { 'ocaml', 'ocaml.interface', 'reason', 'dune' },
  config = function()

require('utils').install_with_mason {
  'ocaml-lsp',
}

vim.lsp.config('ocamllsp', {
  cmd = { 'ocaml-lsp' },
  filetypes = { 'ocaml', 'ocaml.interface', 'reason', 'dune' },
  root_markers = { 'dune-project', 'dune-workspace', '*.opam', 'package.json', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'ocaml', 'ocaml_interface' })

vim.lsp.enable 'ocamllsp'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
