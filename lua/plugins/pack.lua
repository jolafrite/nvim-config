-- vim.pack update engine.
--
-- Owns plugin state and background update checks. Pure data, no UI:
--   :PackCheck      background check for outdated plugins
--   M.check()       run a check programmatically (opts.fetch = false for offline)
--   M.summary()     { checking, status, pending, total } snapshot for statuslines
--
-- Every state change is announced with the `PackStatusChanged` User autocmd;
-- consumers (plugins.pack_float, lualine.components.pack) listen for it.
-- The float UI lives in plugins.pack_float.

local M = {}

M.state = {
  checking = false,
  check_id = 0,
  status = '',
  plugins = {},
  pending = {},
  clean = {},
  not_loaded = {},
}

local config = {
  auto_check = true,
  auto_check_delay = 20000,
  -- Concurrent git fetches. Kept low so checks never make nvim feel sluggish.
  fetch_concurrency = 6,
}

function M.setup(opts) config = vim.tbl_deep_extend('force', config, opts or {}) end

local function is_pending(plugin) return plugin.rev and plugin.rev_to and plugin.rev ~= plugin.rev_to end

local function sort_by_name(items)
  table.sort(items, function(a, b) return a.spec.name < b.spec.name end)
end

-- Coalesce bursts into a single event at most every NOTIFY_INTERVAL ms, so a
-- flood of fetch completions never causes a redraw storm.
local NOTIFY_INTERVAL = 250
local notify_scheduled = false
local last_notify = 0

local function notify()
  if notify_scheduled then return end
  notify_scheduled = true
  local delay = math.max(0, last_notify + NOTIFY_INTERVAL - vim.uv.now())
  vim.defer_fn(function()
    notify_scheduled = false
    last_notify = vim.uv.now()
    vim.api.nvim_exec_autocmds('User', { pattern = 'PackStatusChanged' })
  end, delay)
end

function M.set_plugins(plugins)
  M.state.plugins = plugins
  M.state.pending = {}
  M.state.clean = {}
  M.state.not_loaded = {}

  for _, plugin in ipairs(M.state.plugins) do
    if is_pending(plugin) then
      M.state.pending[#M.state.pending + 1] = plugin
    elseif plugin.active then
      M.state.clean[#M.state.clean + 1] = plugin
    else
      M.state.not_loaded[#M.state.not_loaded + 1] = plugin
    end
  end

  sort_by_name(M.state.plugins)
  sort_by_name(M.state.pending)
  sort_by_name(M.state.clean)
  sort_by_name(M.state.not_loaded)
  notify()
end

local function replace_plugin(plugin)
  local name = plugin.spec.name
  for i, existing in ipairs(M.state.plugins) do
    if existing.spec.name == name then
      M.state.plugins[i] = plugin
      M.set_plugins(M.state.plugins)
      return
    end
  end

  M.state.plugins[#M.state.plugins + 1] = plugin
  M.set_plugins(M.state.plugins)
end

---Load the installed plugin list from disk (no network).
---@return boolean ok
function M.load_plugin_list()
  local ok, plugins_or_err = pcall(vim.pack.get, nil, { info = false })
  if ok then
    M.set_plugins(plugins_or_err)
    return true
  end
  M.state.status = tostring(plugins_or_err)
  notify()
  return false
end

---Refresh plugin state against already fetched refs (offline).
---@param status? string status message to show afterwards
function M.refresh_local(status)
  vim.schedule(function()
    local ok, plugins_or_err = pcall(vim.pack.get, nil, { offline = true })
    if not ok then
      M.state.status = tostring(plugins_or_err)
      notify()
      return
    end

    M.set_plugins(plugins_or_err)
    M.state.status = status or 'ready'
    notify()
  end)
end

---Cancel any running check (e.g. when the float UI closes).
function M.abort()
  M.state.check_id = M.state.check_id + 1
  M.state.checking = false
  notify()
end

local function finish_check(check_id, failures)
  if M.state.check_id ~= check_id then return end

  M.state.checking = false
  M.state.status = failures > 0 and ('ready, %d fetch failed'):format(failures) or 'ready'
  notify()
end

local function check_fetch_async()
  if M.state.checking then return end

  M.state.checking = true
  M.state.status = 'fetching remotes'
  M.state.check_id = M.state.check_id + 1
  local check_id = M.state.check_id
  local total = #M.state.plugins
  local remaining = total
  local failures = 0
  notify()

  if total == 0 then
    finish_check(check_id, failures)
    return
  end

  -- Snapshot the plugin list: replace_plugin() re-sorts the live list, which
  -- would otherwise make index-based workers skip or repeat plugins.
  local queue = { unpack(M.state.plugins, 1, total) }
  local next_index = 0

  -- Bounded worker pool: instead of spawning one git process per plugin all
  -- at once, keep at most `fetch_concurrency` fetches in flight.
  local function fetch_next()
    if M.state.check_id ~= check_id then return end
    next_index = next_index + 1
    local plugin = queue[next_index]
    if not plugin then return end

    vim.system({
      'git',
      '-C',
      plugin.path,
      'fetch',
      '--quiet',
      '--tags',
      '--force',
      '--recurse-submodules=yes',
      'origin',
    }, {}, function(fetch_result)
      vim.schedule(function()
        if M.state.check_id ~= check_id then return end

        if fetch_result.code ~= 0 then
          failures = failures + 1
        else
          local ok, plugin_data = pcall(vim.pack.get, { plugin.spec.name }, { offline = true })
          if ok and plugin_data[1] then
            replace_plugin(plugin_data[1])
          else
            failures = failures + 1
          end
        end

        remaining = remaining - 1
        M.state.status = ('fetching remotes %d/%d'):format(total - remaining, total)
        notify()

        if remaining == 0 then
          finish_check(check_id, failures)
        else
          fetch_next()
        end
      end)
    end)
  end

  for _ = 1, math.min(config.fetch_concurrency, total) do
    fetch_next()
  end
end

---Check plugins for updates. Fetches remotes unless `opts.fetch == false`.
---@param opts? {fetch?: boolean, status?: string}
---@return boolean started false if a check is already running
function M.check(opts)
  opts = opts or {}
  if M.state.checking then return false end

  if #M.state.plugins == 0 then M.load_plugin_list() end
  if opts.fetch == false then
    M.refresh_local(opts.status)
  else
    check_fetch_async()
  end
  return true
end

---Status snapshot for statuslines and scripts.
---@return {checking: boolean, status: string, pending: number, total: number}
function M.summary()
  return {
    checking = M.state.checking,
    status = M.state.status,
    pending = #M.state.pending,
    total = #M.state.plugins,
  }
end

vim.api.nvim_create_user_command('PackCheck', function() M.check() end, {
  desc = 'Check vim.pack plugins for updates in the background',
})

if config.auto_check then vim.defer_fn(function() M.check() end, config.auto_check_delay) end

return M
