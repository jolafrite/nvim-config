-- Rust: rust_analyzer (LSP) + rustfmt conform + clippy lint.
--
-- `rustfmt` and `clippy` are rustup components, not mason tools, so they are
-- not in mason.lua/mason-lspconfig.lua. Install with:
--   rustup component add rustfmt clippy
require('utils').install_with_mason {
	'rust-analyzer',
}

vim.lsp.config('rust_analyzer', {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { 'Cargo.toml', '.git' },
})

vim.lsp.enable 'rust_analyzer'

require("conform").formatters_by_ft.rust = { "rustfmt" }

require("conform").formatters.rustfmt = {
	command = "rustfmt",
	stdin = true,
	args = { "--emit=stdout" },
}

require("lint").linters_by_ft.rust = { "clippy" }

-- Overridden with ignore_exitcode=true: cargo clippy exits 101 when the code
-- doesn't compile, which is expected (can't lint uncompilable code). Without
-- the override nvim-lint reports "Linter command `cargo` exited with code: 101".
require("lint").linters.clippy = vim.tbl_deep_extend(
	"force",
	require("lint").linters.clippy,
	{ ignore_exitcode = true }
)

-- vim: ts=2 sts=2 sw=2 et
