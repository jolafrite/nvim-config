local M = {}

-- Fast implementation to check if a table is a list.
local function is_list(t)
  local i = 0
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then return false end
  end
  return true
end

---@param value any
---@param indent string
local function encode(value, indent)
  local t = type(value)

  if t == 'string' then
    return string.format('%q', value)
  elseif t == 'number' or t == 'boolean' then
    return tostring(value)
  elseif t == 'table' then
    local list = is_list(value)
    local parts = {}
    local next_indent = indent .. '  '

    if list then
      for _, v in ipairs(value) do
        local e = encode(v, next_indent)
        if e then table.insert(parts, next_indent .. e) end
      end
      return '[\n' .. table.concat(parts, ',\n') .. '\n' .. indent .. ']'
    else
      local keys = vim.tbl_keys(value)
      table.sort(keys)
      for _, k in ipairs(keys) do
        local e = encode(value[k], next_indent)
        if e then table.insert(parts, next_indent .. string.format('%q', k) .. ': ' .. e) end
      end
      return '{\n' .. table.concat(parts, ',\n') .. '\n' .. indent .. '}'
    end
  end
end

function M.encode(value) return encode(value, '') end

return M

-- vim: ts=2 sts=2 sw=2 et
