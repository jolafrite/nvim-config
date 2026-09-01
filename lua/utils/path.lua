local M = {}

M.get_filename = function(path)
  -- Find the last occurrence of the path separator.
  local separator = package.config:sub(1, 1) -- Get OS specific path separator
  local pos = string.find(path, separator, nil, true)
  local last_pos = pos
  while pos do
    last_pos = pos
    pos = string.find(path, separator, pos + 1, true)
  end

  if last_pos then
    return path:sub(last_pos + 1)
  else
    -- If no separator is found, the whole path is the filename.
    return path
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
