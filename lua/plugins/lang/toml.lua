-- TOML language support (treesitter + LSP config).
vim.lsp.config("taplo", {})

-- Tree-sitter parser for TOML.
local TS = require("nvim-treesitter")
pcall(TS.install, { "toml" })

-- vim: ts=2 sts=2 sw=2 et
