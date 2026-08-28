-- Lua language support.
--
-- The setup runs on FileType "lua" so lua-language-server and stylua don't
-- load until a Lua buffer is opened. install_with_mason is fire-and-forget;
-- mason's package:install:success handler (see lua/plugins/mason.lua) fires
-- `do FileType` again, re-triggering this autocmd once the tools are ready.

local function find_root_dir(buf_path)
	-- root_dir must resolve to a real directory: lua_ls scans it for
	-- .luarc.json/.luarc.jsonc. The function form isn't invoked by
	-- vim.lsp.start in this Neovim, so compute the path here and pass a
	-- string instead. Walk up from the buffer's directory, not getcwd(),
	-- so scratch files outside the repo still get a workspace root.
	local markers = vim.fs.find({ '.luarc.json', '.luarc.jsonc', '.git' },
		{ path = vim.fs.dirname(buf_path), upward = true })[1]
	return markers and vim.fs.dirname(markers) or vim.fs.dirname(buf_path)
end

local function setup(args)
	require('utils').install_with_mason { 'lua-language-server', 'stylua' }

	---@type vim.lsp.Config
	local server = {
		name = 'lua_ls',
		cmd = { 'lua-language-server' },
		filetypes = { 'lua' },
		root_markers = { '.git' },
		root_dir = find_root_dir(vim.api.nvim_buf_get_name(args.buf)),
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)
		end,
		settings = {
			Lua = {
				format = { enable = false }, -- Disable formatting (formatting is done by stylua)
			},
		},
	}

	vim.lsp.config('lua_ls', server)
	-- vim.lsp.start instead of vim.lsp.enable: enable's FileType autocmd is
	-- registered after the buffer's filetype is already set, so it silently
	-- attaches nothing (returns true, zero clients). start() launches the
	-- client directly using the config registered above.
	vim.lsp.start(server)

	local conform = require 'conform'
	conform.formatters_by_ft.lua = { 'stylua' }
end

require('utils').on_file_types({ 'lua' }, setup)
