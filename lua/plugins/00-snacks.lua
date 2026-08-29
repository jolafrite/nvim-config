local gh = require('utils').gh

vim.pack.add {
  gh 'folke/snacks.nvim',
}

require('snacks').setup {
  bigfile = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = false }, -- set in options.lua
  toggle = { map = vim.keymap.set },
  words = { enabled = true },

  picker = {
		-- stylua: ignore
		---@type snacks.picker.Config
		actions = {
		-- Toggle project root / cwd (taken from the folke/snacks.nvim spec).
		-- Snacks.git.get_root takes a bufnr/path, not a {buf=, normalize=} table.
			toggle_cwd = function(p)
				local root = Snacks.git.get_root(p.input.filter.current_buf)
				local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
				local current = p:cwd()
				p:set_cwd(current == root and cwd or root)
				p:find()
			end,
		},
		-- stylua: ignore
		---@type snacks.picker.Config
		win = {
			input = {
				keys = {
					["<a-c>"] = {
						"toggle_cwd",
						mode = { "n", "i" },
					},
				},
			},
		},
  },
  dashboard = {
    preset = {
			-- stylua: ignore
			---@type snacks.dashboard.Item[]
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
				{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
    },
  },
}

Snacks.toggle({
  name = 'Git Signs',
  get = function() return require('gitsigns.config').config.signcolumn end,
  set = function(state) require('gitsigns').toggle_signs(state) end,
}):map '<leader>uG'

-- stylua: ignore
vim.keymap.set("n", "<leader>n", function()
	if Snacks.config.picker and Snacks.config.picker.enabled then
		Snacks.picker.notifications()
	else
		Snacks.notifier.show_history()
	end
end, { desc = "Notification History" })
vim.keymap.set('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })

-- Snacks.picker keymaps (taken from the folke/snacks.nvim spec keys).
-- These were commented out awaiting a working plugin loader; restored here
-- next to the snacks setup they belong to.
-- stylua: ignore
vim.keymap.set('n', '<leader>,', function() Snacks.picker.buffers() end,
	{ desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', function() Snacks.picker.pick 'live_grep' end, { desc = 'Grep (Root Dir)' })
vim.keymap.set('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command History' })
vim.keymap.set('n', '<leader><space>', function() Snacks.picker.pick 'files' end, { desc = 'Find Files (Root Dir)' })

-- find
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fB', function() Snacks.picker.buffers { hidden = true, nofile = true } end, { desc = 'Buffers (all)' })
vim.keymap.set('n', '<leader>fc', function() Snacks.picker.pick 'config_files' end, { desc = 'Find Config File' })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.pick 'files' end, { desc = 'Find Files (Root Dir)' })
vim.keymap.set('n', '<leader>fF', function() Snacks.picker.pick('files', { root = false }) end, { desc = 'Find Files (cwd)' })
vim.keymap.set('n', '<leader>fg', function() Snacks.picker.git_files() end, { desc = 'Find Files (git-files)' })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.pick 'oldfiles' end, { desc = 'Recent' })
vim.keymap.set('n', '<leader>fR', function() Snacks.picker.recent { filter = { cwd = true } } end, { desc = 'Recent (cwd)' })
vim.keymap.set('n', '<leader>fp', function() Snacks.picker.projects() end, { desc = 'Projects' })

-- -- git
vim.keymap.set('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff (hunks)' })
vim.keymap.set('n', '<leader>gD', function() Snacks.picker.git_diff { base = 'origin', group = true } end, { desc = 'Git Diff (origin)' })
vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
vim.keymap.set('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git Stash' })
vim.keymap.set('n', '<leader>gi', function() Snacks.picker.gh_issue() end, { desc = 'GitHub Issues (open)' })
vim.keymap.set('n', '<leader>gI', function() Snacks.picker.gh_issue { state = 'all' } end, { desc = 'GitHub Issues (all)' })
vim.keymap.set('n', '<leader>gp', function() Snacks.picker.gh_pr() end, { desc = 'GitHub Pull Requests (open)' })
vim.keymap.set('n', '<leader>gP', function() Snacks.picker.gh_pr { state = 'all' } end, { desc = 'GitHub Pull Requests (all)' })

-- -- Grep
vim.keymap.set('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
vim.keymap.set('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.pick 'live_grep' end, { desc = 'Grep (Root Dir)' })
vim.keymap.set('n', '<leader>sG', function() Snacks.picker.pick('live_grep', { root = false }) end, { desc = 'Grep (cwd)' })
vim.keymap.set('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = 'Search for Plugin Spec' })
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.pick 'grep_word' end, { desc = 'Visual selection or word (Root Dir)' })
vim.keymap.set({ 'n', 'x' }, '<leader>sW', function() Snacks.picker.pick('grep_word', { root = false }) end, { desc = 'Visual selection or word (cwd)' })

-- -- search
vim.keymap.set({ 'n', 'x' }, '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Registers' })
vim.keymap.set('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = 'Search History' })
vim.keymap.set('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Autocmds' })
vim.keymap.set('n', '<leader>sc', function() Snacks.picker.command_history() end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Commands' })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help Pages' })
vim.keymap.set('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
vim.keymap.set('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Icons' })
vim.keymap.set('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = 'Location List' })
vim.keymap.set('n', '<leader>sM', function() Snacks.picker.man() end, { desc = 'Man Pages' })
vim.keymap.set('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' })
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Resume' })
vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undotree' })
vim.keymap.set('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })

-- stylua: ignore end

-- Snacks toggles (the <leader>u* group of editor-option toggles)
-- stylua: ignore
Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
Snacks.toggle.diagnostics():map '<leader>ud'
Snacks.toggle.line_number():map '<leader>ul'
Snacks.toggle
  .option('conceallevel', {
    off = 0,
    on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
    name = 'Conceal Level',
  })
  :map '<leader>uc'
Snacks.toggle
  .option('showtabline', {
    off = 0,
    on = vim.o.showtabline > 0 and vim.o.showtabline or 2,
    name = 'Tabline',
  })
  :map '<leader>uA'
Snacks.toggle.treesitter():map '<leader>uT'
Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
Snacks.toggle.dim():map '<leader>uD'
Snacks.toggle.animate():map '<leader>ua'
Snacks.toggle.indent():map '<leader>ug'
Snacks.toggle.scroll():map '<leader>uS'
Snacks.toggle.profiler():map '<leader>dpp'
Snacks.toggle.profiler_highlights():map '<leader>dph'

if vim.lsp.inlay_hint then Snacks.toggle.inlay_hints():map '<leader>uh' end

-- stylua: ignore end

-- lazygit
if vim.fn.executable 'lazygit' == 1 then
  vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit { cwd = Snacks.git.get_root() } end, { desc = 'Lazygit (Root Dir)' })
  vim.keymap.set('n', '<leader>gG', function() Snacks.lazygit() end, { desc = 'Lazygit (cwd)' })
end

vim.keymap.set('n', '<leader>gL', function() Snacks.picker.git_log() end, { desc = 'Git Log (cwd)' })
vim.keymap.set('n', '<leader>gb', function() Snacks.picker.git_log_line() end, { desc = 'Git Blame Line' })
vim.keymap.set('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git Current File History' })
vim.keymap.set('n', '<leader>gl', function() Snacks.picker.git_log { cwd = Snacks.git.get_root() } end, { desc = 'Git Log' })
vim.keymap.set({ 'n', 'x' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse (open)' })
vim.keymap.set({ 'n', 'x' }, '<leader>gY', function()
  Snacks.gitbrowse { open = function(url) vim.fn.setreg('+', url) end, notify = false }
end, { desc = 'Git Browse (copy)' })

-- floating terminal
vim.keymap.set('n', '<leader>fT', function() Snacks.terminal() end, { desc = 'Terminal (cwd)' })
vim.keymap.set('n', '<leader>ft', function() Snacks.terminal(nil, { cwd = Snacks.git.get_root() }) end, { desc = 'Terminal (Root Dir)' })
vim.keymap.set({ 'n', 't' }, '<c-/>', function() Snacks.terminal.focus(nil, { cwd = Snacks.git.get_root() }) end, { desc = 'Terminal (Root Dir)' })
vim.keymap.set({ 'n', 't' }, '<c-_>', function() Snacks.terminal.focus(nil, { cwd = Snacks.git.get_root() }) end, { desc = 'which_key_ignore' })

-- Snacks toggles for zoom/zen
Snacks.toggle.zoom():map('<leader>wm'):map '<leader>uZ'
Snacks.toggle.zen():map '<leader>uz'

-- Run Lua snippet on lua files (filetype-scoped keymaps need an autocmd; vim.keymap.set alone has no filetype equivalent)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function(ev)
    vim.keymap.set({ 'n', 'x' }, '<localleader>r', function() Snacks.debug.run() end, { desc = 'Run Lua', buffer = ev.buf })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
