local lang_path = vim.fn.stdpath("config") .. "/lua/plugins/lang"

for _, file in ipairs(vim.fn.glob(lang_path .. "/*.lua", true, true)) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  if name ~= "init" and not package.loaded["plugins.lang." .. name] then
    local chunk, err = loadfile(file)
    if not chunk then
      error("loadfile " .. file .. ": " .. tostring(err))
    end
    chunk()
    package.loaded["plugins.lang." .. name] = true
  end
end

package.loaded["plugins.lang"] = true
