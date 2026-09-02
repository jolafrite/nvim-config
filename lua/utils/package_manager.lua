local M = {}

local pending = {}

local startup = {}
local by_event = {}
local by_ft = {}

local activated = false

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

local function late_add(spec)
  if not spec.event and not spec.filetype then
    load_spec(spec)
    return
  end

  if spec.event then
    -- Event-triggered: load_all registers these pattern-less, so match that.
    -- If the event already fired for an open buffer (FileType), load now.
    local events = to_list(spec.event)
    if vim.list_contains(events, 'FileType') then
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
          load_spec(spec)
          return
        end
      end
    end
    vim.api.nvim_create_autocmd(events, {
      once = true,
      callback = function()
        load_spec(spec)
        return true
      end,
    })
    return
  end

  -- Filetype-triggered: fire only for the declared filetypes (never for any
  -- FileType event), after checking buffers that are already open.
  local fts = to_list(spec.filetype)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.list_contains(fts, vim.bo[buf].filetype) then
      load_spec(spec)
      return
    end
  end
  vim.api.nvim_create_autocmd('FileType', {
    pattern = fts,
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

  for _, spec in ipairs(pending) do
    late_add(spec)
  end
end

_G.PackageManager = M
return M
