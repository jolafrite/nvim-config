-- lua/utils/package_manager.lua
local M = {}
local plugins = {}

function M.add(spec) table.insert(plugins, spec) end

function M.load_all()
  local startup, by_event, by_ft = {}, {}, {}

  for _, spec in ipairs(plugins) do
    if spec.event then
      local events = type(spec.event) == 'string' and { spec.event } or spec.event
      for _, e in ipairs(events) do
        by_event[e] = by_event[e] or {}
        table.insert(by_event[e], spec)
      end
    elseif spec.filetype then
      local fts = type(spec.filetype) == 'string' and { spec.filetype } or spec.filetype
      for _, f in ipairs(fts) do
        by_ft[f] = by_ft[f] or {}
        table.insert(by_ft[f], spec)
      end
    else
      table.insert(startup, spec)
    end
  end

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

  local ft_loaded = {}
  vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileType' }, {
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
      if ft == '' then return end
      if by_ft[ft] and not ft_loaded[ft] then
        ft_loaded[ft] = true
        for _, s in ipairs(by_ft[ft]) do
          load_spec(s)
        end
      end
    end,
  })
end

_G.PackageManager = M
return M
