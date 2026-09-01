PackageManager.add({
  name = 'lang.prisma',
  filetype = { 'prisma' },
  config = function()

require('utils').install_with_mason {
  'prisma-language-server',
}

vim.lsp.config('prismals', {
  cmd = { 'prisma-language-server', '--stdio' },
  filetypes = { 'prisma' },
  root_markers = { 'schema.prisma', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'prisma' })

vim.lsp.enable 'prismals'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
