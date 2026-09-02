local plugin_path = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.glob(plugin_path .. "/*.lua", true, true)) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  if name ~= "init" then
    local req_name = name:match("^%d+%-?(.*)$") or name
    if not package.loaded["plugins." .. req_name] then
      local fn, err = loadfile(file)
      if not fn then
        error("loadfile " .. file .. ": " .. tostring(err))
      end
      fn()
      package.loaded["plugins." .. req_name] = true
    end
  end
end

PackageManager.load_all()

require("plugins.lang")
