local M = {}

M.install_with_mason = function(patterns)
  local list = type(patterns) == "string" and { patterns } or patterns

  local ok, mr = pcall(require, "mason-registry")
  if not ok then
    vim.notify(
      ("mason-registry unavailable: %s"):format(mr),
      vim.log.levels.WARN
    )
    return
  end

  mr.refresh(function()
    for _, tool in ipairs(list) do
      local ok_p, p = pcall(mr.get_package, tool)
      if not ok_p then
        vim.notify(
          ("mason: unknown package %q"):format(tool),
          vim.log.levels.WARN
        )
      elseif not p:is_installed() then
        p:install()
      end
    end
  end)
end

return M

-- vim: ts=2 sts=2 sw=2 et
