return function()
	local icons = {
		diagnostics = require("plugins.utils.icons").get("diagnostics"),
		documents = require("plugins.utils.icons").get("documents"),
		git = require("plugins.utils.icons").get("git"),
		ui = require("plugins.utils.icons").get("ui"),
	}

	--This is the modern method of modifying nvim-tree keymaps
	-- Reference: https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
	local function my_on_attach(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		api.config.mappings.default_on_attach(bufnr)

		-- your removals of default mappings and creation of new mappings go here
		vim.keymap.set("n", "<Tab>", api.node.open.edit, opts("Open"))
	end

    require("nvim-tree").setup({
		on_attach = my_on_attach,
		hijack_cursor = true,
		hijack_unnamed_buffer_when_opening = true,
		sync_root_with_cwd = true,
		view = {
			adaptive_size = true,
		},
		renderer = {
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
			indent_markers = {
				enable = true,
			},
			icons = {
				git_placement = "before",
				symlink_arrow = " ➛ ",
				glyphs = {
					default = icons.documents.Default,
					symlink = icons.documents.Symlink,
					bookmark = icons.ui.BookMark,
                    modified = icons.ui.Modified_alt,
					folder = {
						arrow_open = "",
						arrow_closed = "",
                        default = icons.ui.Folder,
						open = icons.ui.FolderOpen,
						empty = icons.ui.EmptyFolder,
						empty_open = icons.ui.EmptyFolderOpen,
						symlink = icons.ui.SymlinkFolder,
						symlink_open = icons.ui.FolderOpen,
					},
					git = {
						unstaged = icons.git.Mod_alt,
						staged = icons.git.Add,
						unmerged = icons.git.Unmerged,
						renamed = icons.git.Rename,
						untracked = icons.git.Untracked,
						deleted = icons.git.Remove,
						ignored = icons.git.Ignore,
					},
				},
			},
		},
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		filters = {
            git_ignored = false,
			custom = { ".DS_Store" },
		},
		actions = {
			open_file = {
				resize_window = false,
			},
		},
		diagnostics = {
			icons = {
				hint = icons.diagnostics.Hint_alt,
				info = icons.diagnostics.Information_alt,
				warning = icons.diagnostics.Warning_alt,
				error = icons.diagnostics.Error_alt,
			},
		},
	})
end
