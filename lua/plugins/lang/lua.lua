-- Lua language support.
--
-- The setup runs on FileType "lua" so lua-language-server and stylua don't
-- load until a Lua buffer is opened. install_with_mason is fire-and-forget;
-- mason's package:install:success handler (see lua/plugins/mason.lua) fires
-- `do FileType` again, re-triggering this autocmd once the tools are ready.

-- Root directory for lua_ls workspace discovery. Delegates to
-- utils.root.get, which walks the default spec (lsp, { '.git', 'lua' },
-- cwd) so the LSP root_dir and a .git marker both feed the result,
-- rather than only the first .luarc.json/.git marker walking up from
-- the buffer's directory.
local function root_dir(buf_path)
	return require('utils').root.get({ buf = 0, normalize = false })
end

local function setup(args)
	require('utils').install_with_mason { 'lua-language-server', 'stylua' }

	---@type vim.lsp.Config
	local server = {
		name = 'lua_ls',
		cmd = { 'lua-language-server' },
		filetypes = { 'lua' },
		root_markers = { '.git' },
		root_dir = root_dir(vim.api.nvim_buf_get_name(args.buf)),
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
