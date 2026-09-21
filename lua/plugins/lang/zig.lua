local gh = require('utils').gh

PackageManager.add_with_mason { 'zls' }

PackageManager.add {
  [1] = gh 'lawrence-laz/neotest-zig',
  lazy = false,
}

vim.lsp.config('zls', {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', 'build.zig.zon', '.git' },
})

PackageManager.add_formatter('zig', 'zigfmt')

PackageManager.add_with_treesitter { 'zig' }

PackageManager.add_tester({ 'zig', 'zir' }, { ['neotest-zig'] = {} })

vim.lsp.enable 'zls'
