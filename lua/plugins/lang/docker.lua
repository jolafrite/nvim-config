-- Docker language support (treesitter + LSP config).
vim.lsp.config('dockerls', {})
vim.lsp.config('docker_compose_language_service', {})
local lint = require("lint")
lint.linters_by_ft.dockerfile = { "hadolint" }
