-- lua/utils/package_manager.lua
--
-- Minimal plugin loader on top of vim.pack.
--
-- Specs are registered with PackageManager.add(spec) and activated by
-- load_all(), which loads startup specs immediately and arms filetype/event
-- triggers for the rest. add() also works after load_all() (e.g. from
-- lua/plugins/lang/*): trigger-less specs are loaded on the spot, trigger-based
-- specs are armed as one-shot autocmds — after a scan for already-open buffers
-- whose trigger has fired.
local M = {}

local pending = {} -- specs registered before load_all()

-- Trigger tables read by the autocmds at fire time.
local startup = {}
local by_event = {}
local by_ft = {}

local activated = false -- load_all() has run

local function to_list(v) return type(v) == 'string' and { v } or v end

local function load_spec(s)
  if s.loaded then return end

  s.loaded = true
  local to_add = {}
  for _, dep in ipairs(s.dependencies or {}) do
    table.insert(to_add, dep)
  end
  table.insert(to_add, s[1])
  local ok, err = pcall(vim.pack.add, to_add, { load = true, confirm = false })
  if not ok then vim.notify('package_manager: failed to load ' .. tostring(s[1]) .. ': ' .. tostring(err), vim.log.levels.WARN) end
  if s.config then pcall(s.config) end
end

-- Activate a spec registered after load_all().
local function late_add(spec)
  if not spec.event and not spec.filetype then
    load_spec(spec)
    return
  end

  -- Filetypes the spec reacts to: explicit ones, plus any filetype when the
  -- spec triggers on FileType.
  local fts = {}
  for _, f in ipairs(to_list(spec.filetype or {})) do
    fts[f] = true
  end
  for _, e in ipairs(to_list(spec.event or {})) do
    if e == 'FileType' then fts['*'] = true end
  end

  -- A matching open buffer means the trigger already fired: load now.
  if next(fts) then
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        local ft = vim.bo[buf].filetype
        if fts[ft] or (fts['*'] and ft ~= '') then
          load_spec(spec)
          return
        end
      end
    end
  end

  -- Otherwise arm a one-shot trigger. load_spec is guarded, so an extra
  -- fire (e.g. the same spec also reached by_ft) is harmless.
  vim.api.nvim_create_autocmd(to_list(spec.event or 'FileType'), {
    once = true,
    callback = function()
      load_spec(spec)
      return true
    end,
  })
end

function M.add(spec)
  if not activated then
    table.insert(pending, spec)
  else
    late_add(spec)
  end
end

function M.load_all()
  local registered = pending
  pending = {}

  for _, spec in ipairs(registered) do
    if spec.event then
      for _, e in ipairs(to_list(spec.event)) do
        by_event[e] = by_event[e] or {}
        table.insert(by_event[e], spec)
      end
    elseif spec.filetype then
      for _, f in ipairs(to_list(spec.filetype)) do
        by_ft[f] = by_ft[f] or {}
        table.insert(by_ft[f], spec)
      end
    else
      table.insert(startup, spec)
    end
  end

  for _, s in ipairs(startup) do
    load_spec(s)
  end

  for event, specs in pairs(by_event) do
    vim.api.nvim_create_autocmd(event, {
      callback = function()
        for _, s in ipairs(specs) do
          load_spec(s)
        end
        return true
      end,
    })
  end

  vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileType' }, {
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
      if ft == '' then return end
      for _, s in ipairs(by_ft[ft] or {}) do
        load_spec(s)
      end
    end,
  })

  activated = true

  -- Specs registered while load_all() was running (e.g. from a config fn).
  for _, spec in ipairs(pending) do
    late_add(spec)
  end
end

_G.PackageManager = M
return M
