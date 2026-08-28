-- Rust: rust_analyzer (in config.lsp) + rustfmt conform + clippy lint.
--
-- `rustfmt` and `clippy` are rustup components, not mason tools, so they are
-- not in mason.lua/mason-lspconfig.lua. Install with:
--   rustup component add rustfmt clippy

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
