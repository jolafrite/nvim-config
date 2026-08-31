-- vim.pack plugin manager UI (lazy-style float).
--
-- Data and update checks live in plugins.pack; this module only renders and
-- takes input. It stays in sync by listening for `PackStatusChanged`.
--
-- Commands:
--   :PackFloat      open UI and fetch/check updates
--   :PackFloat!     open UI without fetching, using already fetched refs
--
-- Keys (inside the window): r refresh, u update, U update all, x uninstall,
-- Enter toggle details, ]] / [[ jump between plugins, q / <Esc> close.

local api = vim.api
local pack = require 'plugins.pack'

local M = {}

local ns = api.nvim_create_namespace 'pack_float_ui'
local config = {
  highlights = {
    commit_time = 'PackFloatCommitTime',
  },
}

-- Engine state (lua/plugins/pack.lua). The engine mutates this table in place.
local engine = pack.state

-- UI-only state.
local state = {
  bufnr = nil,
  winid = nil,
  autocmd = nil,
  update_autocmds = nil,
  commits = {},
  commits_requested = {},
  check_id_seen = 0,
  expanded = {},
  update_status = {},
  line_to_name = {},
  name_to_line = {},
}

M.state = state

local function setup_highlights()
  local links = {
    PackFloatTitle = 'Title',
    PackFloatBorder = 'Number',
    PackFloatSection = 'Label',
    PackFloatPending = 'NormalFloat',
    PackFloatClean = 'NormalFloat',
    PackFloatMuted = 'Comment',
    PackFloatHash = 'Number',
    PackFloatKey = 'Keyword',
    PackFloatCommitTime = 'Comment',
    PackFloatError = 'DiagnosticError',
    PackFloatProgress = 'DiagnosticInfo',
    PackFloatDone = 'DiagnosticOk',
  }
  for group, link in pairs(links) do
    api.nvim_set_hl(0, group, { link = link, default = true })
  end
end

function M.setup(opts)
  opts = opts or {}
  config = vim.tbl_deep_extend('force', config, opts)
end

local function valid_window() return state.winid and api.nvim_win_is_valid(state.winid) end

local function valid_buffer() return state.bufnr and api.nvim_buf_is_valid(state.bufnr) end

local function plugin_at_cursor()
  if not valid_window() then return nil end
  local row = api.nvim_win_get_cursor(state.winid)[1]
  return state.line_to_name[row]
end

local function split_lines(text)
  local lines = {}
  for line in (text or ''):gmatch '[^\n]+' do
    lines[#lines + 1] = line
  end
  return lines
end

local function short_rev(rev) return rev and rev:sub(1, 7) or 'unknown' end

local function reset_ui_data()
  state.commits = {}
  state.commits_requested = {}
  state.expanded = {}
  state.update_status = {}
  state.line_to_name = {}
  state.name_to_line = {}
end

local render

local function set_lines(lines, hls)
  if not valid_buffer() then return end

  vim.bo[state.bufnr].modifiable = true
  api.nvim_buf_set_lines(state.bufnr, 0, -1, false, lines)
  vim.bo[state.bufnr].modifiable = false
  vim.bo[state.bufnr].modified = false

  api.nvim_buf_clear_namespace(state.bufnr, ns, 0, -1)
  for _, hl in ipairs(hls) do
    api.nvim_buf_set_extmark(state.bufnr, ns, hl[1], hl[2], {
      end_col = hl[3],
      hl_group = hl[4],
    })
  end
end

local function build_content()
  local lines = {}
  local hls = {}
  local line_to_name = {}
  local name_to_line = {}

  local function add(text, hl)
    local row = #lines
    lines[#lines + 1] = text
    if hl then hls[#hls + 1] = { row, 0, #text, hl } end
    return row
  end

  local function add_hl(row, start_col, end_col, hl) hls[#hls + 1] = { row, start_col, end_col, hl } end

  local function mark_plugin(row, name)
    line_to_name[row + 1] = name
    name_to_line[name] = name_to_line[name] or row + 1
  end

  add ''

  local help = ' [r] refresh  [u] update  [U] update all  [x] uninstall  [Enter] details  [q] close'
  local help_row = add(help)
  for start_pos, end_pos in help:gmatch '()%b[]()' do
    add_hl(help_row, start_pos - 1, end_pos - 1, 'PackFloatKey')
  end

  add ''

  local plugin_indent = '   '
  local detail_indent = '     '

  local function format_version(version)
    if version == nil then return 'default branch' end
    return tostring(version)
  end

  local function split_commit(commit)
    local hash, rest = tostring(commit or ''):match '^(%x+)%s*(.*)$'
    if not hash then return tostring(commit or ''), '' end

    return hash, rest
  end

  local function conventional_prefix_len(message)
    return message:match '^[%w_-]+%b()!:' and #message:match '^[%w_-]+%b()!:'
      or message:match '^[%w_-]+%b():' and #message:match '^[%w_-]+%b():'
      or message:match '^[%w_-]+!:' and #message:match '^[%w_-]+!:'
      or message:match '^[%w_-]+:' and #message:match '^[%w_-]+:'
      or nil
  end

  local function commit_time_range(message) return message:find '%([^()]+%)$' end

  local function add_plugin(plugin, pending)
    local name = plugin.spec.name
    local commits = state.commits[name]
    local progress = state.update_status[name]
    local line = plugin_indent .. name .. (progress and ('  ' .. progress) or '')
    local revision = pending and ('%s → %s'):format(short_rev(plugin.rev), short_rev(plugin.rev_to)) or short_rev(plugin.rev)

    local row = add(line)
    mark_plugin(row, name)

    local name_start = #plugin_indent
    add_hl(row, name_start, name_start + #name, pending and 'PackFloatPending' or 'PackFloatClean')
    if progress then
      local progress_start = #plugin_indent + #name + 2
      add_hl(row, progress_start, #line, progress == 'updated' and 'PackFloatDone' or progress == 'failed' and 'PackFloatError' or 'PackFloatProgress')
    end
    if state.expanded[name] then
      add((detail_indent .. 'path      %s'):format(plugin.path), 'PackFloatMuted')
      mark_plugin(#lines - 1, name)
      add((detail_indent .. 'src       %s'):format(plugin.spec.src), 'PackFloatMuted')
      mark_plugin(#lines - 1, name)
      add((detail_indent .. 'version   %s'):format(format_version(plugin.spec.version)), 'PackFloatMuted')
      mark_plugin(#lines - 1, name)
      add((detail_indent .. 'revision  %s'):format(revision), 'PackFloatMuted')
      mark_plugin(#lines - 1, name)
      if not pending then
        add('', 'PackFloatMuted')
        mark_plugin(#lines - 1, name)
      end
    end

    if pending then
      if state.expanded[name] then
        add('', 'PackFloatMuted')
        mark_plugin(#lines - 1, name)
      end

      if commits == nil then
        add(detail_indent .. 'commits: loading...', 'PackFloatMuted')
        mark_plugin(#lines - 1, name)
      elseif #commits == 0 then
        add(detail_indent .. 'commits: no new commits found', 'PackFloatMuted')
        mark_plugin(#lines - 1, name)
      else
        for _, commit in ipairs(commits) do
          local hash, message = split_commit(commit)
          local commit_line = message ~= '' and (detail_indent .. '%s  %s'):format(hash, message) or (detail_indent .. hash)
          local commit_row = add(commit_line)
          mark_plugin(commit_row, name)
          if hash:match '^%x+$' then add_hl(commit_row, #detail_indent, #detail_indent + #hash, 'PackFloatHash') end
          local prefix_len = conventional_prefix_len(message)
          local message_start = #detail_indent + #hash + 2
          if prefix_len then add_hl(commit_row, message_start, message_start + prefix_len, 'PackFloatKey') end
          local time_start, time_end = commit_time_range(message)
          local time_hl = config.highlights.commit_time
          if time_start and time_hl then add_hl(commit_row, message_start + time_start - 1, message_start + time_end, time_hl) end
        end
      end

      add('', 'PackFloatMuted')
      mark_plugin(#lines - 1, name)
    end
  end

  add((' Updates (%d)'):format(#engine.pending), 'PackFloatSection')
  if #engine.pending == 0 then
    add(engine.checking and '   checking...' or '   no pending updates', 'PackFloatMuted')
  else
    for _, plugin in ipairs(engine.pending) do
      add_plugin(plugin, true)
    end
  end

  add ''
  add((' Loaded (%d)'):format(#engine.clean), 'PackFloatSection')
  for _, plugin in ipairs(engine.clean) do
    add_plugin(plugin, false)
  end

  add ''
  add((' Inactive (%d)'):format(#engine.not_loaded), 'PackFloatSection')
  if #engine.not_loaded == 0 then
    add('  no inactive plugins', 'PackFloatMuted')
  else
    for _, plugin in ipairs(engine.not_loaded) do
      add_plugin(plugin, false)
    end
  end

  state.line_to_name = line_to_name
  state.name_to_line = name_to_line

  return lines, hls
end

render = function()
  if not valid_buffer() then return end
  local lines, hls = build_content()
  set_lines(lines, hls)
end

local function load_commits(plugin)
  local name = plugin.spec.name
  state.commits[name] = nil
  vim.system({
    'git',
    '-C',
    plugin.path,
    'log',
    '--pretty=format:%h %s (%cr)',
    '--abbrev-commit',
    '--date=short',
    '--color=never',
    '--no-show-signature',
    plugin.rev .. '..' .. plugin.rev_to,
  }, { text = true }, function(result)
    vim.schedule(function()
      if state.check_id_seen ~= engine.check_id then return end
      state.commits[name] = result.code == 0 and split_lines(result.stdout) or {}
      render()
    end)
  end)
end

---Re-align UI caches after engine state changes and fetch commit details
---for newly pending plugins.
local function sync_ui()
  if state.check_id_seen ~= engine.check_id then
    state.check_id_seen = engine.check_id
    state.commits = {}
    state.commits_requested = {}
    state.update_status = {}
  end
end

api.nvim_create_autocmd('User', {
  pattern = 'PackStatusChanged',
  callback = function()
    if not valid_buffer() then return end
    sync_ui()
    for _, plugin in ipairs(engine.pending) do
      local name = plugin.spec.name
      if not state.commits_requested[name] then
        state.commits_requested[name] = true
        load_commits(plugin)
      end
    end
    render()
  end,
})

local function set_update_status(name, status)
  if not name or state.update_status[name] == nil then return end
  state.update_status[name] = status
  if valid_buffer() then vim.schedule(render) end
end

local function handle_pack_changed(status)
  return function(ev)
    local data = ev.data or {}
    if data.kind ~= 'update' or not data.spec then return end
    set_update_status(data.spec.name, status)
  end
end

local function clear_update_autocmds()
  if not state.update_autocmds then return end
  for _, autocmd in ipairs(state.update_autocmds) do
    pcall(api.nvim_del_autocmd, autocmd)
  end
  state.update_autocmds = nil
end

local function setup_update_autocmds()
  if state.update_autocmds then return end
  state.update_autocmds = {
    api.nvim_create_autocmd('PackChangedPre', { callback = handle_pack_changed 'updating' }),
    api.nvim_create_autocmd('PackChanged', { callback = handle_pack_changed 'updated' }),
  }
end

local function close()
  if state.autocmd then
    pcall(api.nvim_del_autocmd, state.autocmd)
    state.autocmd = nil
  end
  if valid_window() then api.nvim_win_close(state.winid, true) end
  state.winid = nil
  state.bufnr = nil
  pack.abort()
  clear_update_autocmds()
end

local function update_plugins(names)
  if #names == 0 then
    vim.notify('vim.pack: no pending updates', vim.log.levels.INFO)
    return
  end

  state.update_status = {}
  for _, name in ipairs(names) do
    state.update_status[name] = 'queued'
  end
  render()

  vim.schedule(function()
    local ok, err = pcall(vim.pack.update, names, { force = true, offline = true })
    if not ok then
      vim.notify('vim.pack: ' .. tostring(err), vim.log.levels.ERROR)
      for _, name in ipairs(names) do
        if state.update_status[name] ~= 'updated' then state.update_status[name] = 'failed' end
      end
      render()
      return
    end
    for _, name in ipairs(names) do
      if state.update_status[name] ~= 'updated' then state.update_status[name] = 'failed' end
    end
    render()
    pack.refresh_local()
  end)
end

local function update_current()
  local name = plugin_at_cursor()
  if not name then return end
  for _, plugin in ipairs(engine.pending) do
    if plugin.spec.name == name then
      update_plugins { name }
      return
    end
  end
  vim.notify(('vim.pack: %s has no pending update'):format(name), vim.log.levels.INFO)
end

local function update_all()
  local names = vim.iter(engine.pending):map(function(plugin) return plugin.spec.name end):totable()
  update_plugins(names)
end

local function uninstall_current()
  local name = plugin_at_cursor()
  if not name then return end

  if not vim.pack.del then
    vim.notify('vim.pack.del is unavailable', vim.log.levels.ERROR)
    return
  end

  local prompt = ('Uninstall %s from disk?\n' .. 'Remove its vim.pack.add() spec too, or it may reinstall on restart.'):format(name)
  local choice = vim.fn.confirm(prompt, '&Uninstall\n&Cancel', 2)
  if choice ~= 1 then return end

  pack.abort()
  state.update_status = {}
  render()

  vim.schedule(function()
    local ok, err = pcall(vim.pack.del, { name }, { force = true })
    if not ok then
      vim.notify('vim.pack: ' .. tostring(err), vim.log.levels.ERROR)
      return
    end

    state.commits[name] = nil
    state.expanded[name] = nil
    vim.notify(('vim.pack: uninstalled %s'):format(name), vim.log.levels.INFO)
    pack.refresh_local(('removed %s'):format(name))
  end)
end

local function jump(direction)
  if not valid_window() then return end
  local row = api.nvim_win_get_cursor(state.winid)[1]
  local rows = vim.tbl_keys(state.line_to_name)
  table.sort(rows)
  if direction > 0 then
    for _, next_row in ipairs(rows) do
      if next_row > row then
        api.nvim_win_set_cursor(state.winid, { next_row, 0 })
        return
      end
    end
    if rows[1] then api.nvim_win_set_cursor(state.winid, { rows[1], 0 }) end
  else
    for i = #rows, 1, -1 do
      if rows[i] < row then
        api.nvim_win_set_cursor(state.winid, { rows[i], 0 })
        return
      end
    end
    if rows[#rows] then api.nvim_win_set_cursor(state.winid, { rows[#rows], 0 }) end
  end
end

local function toggle_details()
  local name = plugin_at_cursor()
  if not name then return end
  state.expanded[name] = not state.expanded[name]
  render()
  if valid_window() and state.name_to_line[name] then api.nvim_win_set_cursor(state.winid, { state.name_to_line[name], 0 }) end
end

local function map(lhs, rhs, desc) vim.keymap.set('n', lhs, rhs, { buffer = state.bufnr, silent = true, nowait = true, desc = desc }) end

local function setup_keymaps()
  map('q', close, 'Close')
  map('<Esc>', close, 'Close')
  map('r', function() pack.check() end, 'Refresh updates')
  map('u', update_current, 'Update plugin')
  map('U', update_all, 'Update all pending')
  map('x', uninstall_current, 'Uninstall plugin')
  map('<CR>', toggle_details, 'Toggle details')
  map(']]', function() jump(1) end, 'Next plugin')
  map('[[', function() jump(-1) end, 'Previous plugin')
end

function M.open(opts)
  opts = opts or {}

  if valid_window() then
    api.nvim_set_current_win(state.winid)
    return
  end

  setup_highlights()

  state.bufnr = api.nvim_create_buf(false, true)
  vim.bo[state.bufnr].buftype = 'nofile'
  vim.bo[state.bufnr].bufhidden = 'wipe'
  vim.bo[state.bufnr].swapfile = false
  vim.bo[state.bufnr].filetype = 'pack-float'

  local columns = vim.o.columns
  local screen_lines = vim.o.lines
  local width = math.min(100, math.max(64, math.floor(columns * 0.82)))
  local height = math.min(32, math.max(18, math.floor(screen_lines * 0.72)))

  state.winid = api.nvim_open_win(state.bufnr, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((screen_lines - height) / 2),
    col = math.floor((columns - width) / 2),
    style = 'minimal',
    border = 'solid',
    title = ' vim.pack ',
    title_pos = 'center',
  })

  vim.wo[state.winid].cursorline = true
  vim.wo[state.winid].wrap = true
  vim.wo[state.winid].linebreak = true
  vim.wo[state.winid].breakindent = true

  reset_ui_data()
  if #engine.plugins == 0 then pack.load_plugin_list() end
  sync_ui()
  setup_keymaps()
  setup_update_autocmds()
  render()

  local captured_win = state.winid
  state.autocmd = api.nvim_create_autocmd('WinClosed', {
    once = true,
    callback = function(ev)
      if vim._tointeger(ev.match) == captured_win then close() end
    end,
  })

  pack.check { fetch = opts.fetch ~= false }
end

api.nvim_create_user_command('PackFloat', function(command) M.open { fetch = not command.bang } end, {
  bang = true,
  desc = 'Open lazy-style vim.pack UI',
})

return M
