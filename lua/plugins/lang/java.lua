-- Java language support (treesitter + LSP config).
--
-- jdtls requires the nvim-jdtls plugin, which is NOT installed here.
-- Guard so the server config is registered but never enabled without it.
if pcall(require, "jdtls") then
	vim.lsp.config('jdtls',
{}
)

end
