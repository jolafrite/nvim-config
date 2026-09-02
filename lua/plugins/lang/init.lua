-- Language configuration loader.
--
-- Every file in this directory is loaded exactly once, after the plugins
-- themselves (see lua/plugins/init.lua). Two shapes coexist and no file has to
-- declare which one it is:
--
--   * Spec files call PackageManager.add(...) with a filetype/event trigger.
--     PackageManager handles specs registered after load_all(), so they work
--     from here too — the trigger is armed on the spot.
--   * Config files run top-level setup for startup-loaded plugins (conform,
--     nvim-lint, nvim-treesitter, vim.lsp.config/enable). Those plugins are
--     guaranteed to be loaded because load_all() has already run.
--
-- To disable a language, put a bare `return` at the top of its file.

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

-- vim: ts=2 sts=2 sw=2 et
