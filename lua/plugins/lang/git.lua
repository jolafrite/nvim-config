-- Git language support (treesitter + LSP config).
--
-- No LSP server is configured for git — only treesitter parsers
-- (git_config, gitcommit, git_rebase, gitignore, gitattributes).
-- Completion for branches, subjects and references is provided by
-- blink-cmp-git (see blink.lua).

-- Tree-sitter parsers for Git-related filetypes.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'git_config', 'gitcommit', 'gitattributes', 'gitignore', 'git_rebase' })

-- vim: ts=2 sts=2 sw=2 et
