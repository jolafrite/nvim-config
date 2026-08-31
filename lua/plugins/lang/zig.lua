local gh = require('utils').gh

PackageManager.add({
  [1] = gh 'lawrence-laz/neotest-zig',
  filetype = {'zig', 'zir'},
  config = function()

require('utils').install_with_mason {
  'zls',
}

vim.lsp.config('zls', {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', '.git' },
})

vim.lsp.enable 'zls'

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'zig' })

pcall(function()
  require('neotest').setup {
    adapters = {
      ['neotest-zig'] = {},
    },
  }
end)

-- vim: ts=2 sts=2 sw=2 et
  end,
})

-- vim: ts=2 sts=2 sw=2 et
