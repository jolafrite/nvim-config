-- No LSP server for git; branch/ref completion comes from blink-cmp-git (blink.lua).
PackageManager.add({
  name = 'lang.git',
  filetype = { 'gitconfig', 'gitcommit', 'gitattributes', 'gitignore', 'gitrebase', 'git' },
  config = function()

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'git_config', 'gitcommit', 'gitattributes', 'gitignore', 'git_rebase' })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
