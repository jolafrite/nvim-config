local M = {}

M.gh = function(repo) return 'https://github.com/' .. repo end
M.cb = function(repo) return 'https://codeberg.org/' .. repo end

-- Register an autocmd that fires once per matching filetype, runs the callback.
M.on_file_types = function(patterns, fn)
  local list = type(patterns) == 'string' and { patterns } or patterns
  vim.api.nvim_create_autocmd('FileType', {
    pattern = list,
    once = true,
    callback = function(args)
      fn(args)
      -- Run any plugin-provided ftplugin for this filetype so plugins
      -- that ship runtime files still see their ftplugin load.
      vim.cmd('runtime! ftplugin/' .. vim.bo.filetype .. '.lua')
      vim.cmd('runtime! ftplugin/' .. vim.bo.filetype .. '.vim')
    end,
  })
end

-- Register a callback that runs once when the first LSP client attaches.
M.on_lsp_attach = function(fn)
  vim.api.nvim_create_autocmd('LSPAttach', {
    once = true,
    callback = function(args) fn(args) end,
  })
end

-- Register a callback that runs once when the first real buffer is
-- opened. Equivalent to on_file_types('*') but reads as intent.
M.on_buf_read = function(fn)
  vim.api.nvim_create_autocmd('BufReadPost', {
    once = true,
    callback = function(args) fn(args) end,
  })
end

M.run_build = function(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

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

M.get_lua_filenames_without_extension = function()
  local filenames = vim.fn.glob(vim.fn.stdpath 'config' .. '/lsp/*.lua')
  local filename_table = vim.split(filenames, '\n')
  local result = {}
  for _, path in ipairs(filename_table) do
    local fn = M.get_filename(path)
    if fn:match 'init%.lua$' then goto continue end
    local name = vim.fn.fnamemodify(fn, ':r')
    table.insert(result, name)
    ::continue::
  end
  return result
end

return M

-- vim: ts=2 sts=2 sw=2 et
