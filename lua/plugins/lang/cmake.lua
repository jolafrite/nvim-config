-- CMake language support (treesitter + LSP config).
vim.lsp.config('neocmake', {})
local lint = require("lint")
lint.linters_by_ft.cmake = { "cmakelint" }
