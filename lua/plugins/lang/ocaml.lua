PackageManager.add_with_mason {
  'ocaml-lsp',
}

vim.lsp.config('ocamllsp', {
  cmd = { 'ocaml-lsp' },
  filetypes = { 'ocaml', 'ocaml.interface', 'reason', 'dune' },
  root_markers = { 'dune-project', 'dune-workspace', '*.opam', 'package.json', '.git' },
})

PackageManager.add_with_treesitter({ 'ocaml', 'ocaml_interface' })

vim.lsp.enable 'ocamllsp'
