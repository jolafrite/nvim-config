local TS = require 'nvim-treesitter'
pcall(TS.install, { 'git_config', 'gitcommit', 'gitattributes', 'gitignore', 'git_rebase' })
