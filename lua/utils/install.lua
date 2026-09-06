local log = require 'utils.log'
local M = {}

M.install_with_mason = function(patterns)
  local list = type(patterns) == 'string' and { patterns } or patterns

  local ok, mr = pcall(require, 'mason-registry')
  if not ok then
    log.warn(('mason-registry unavailable: %s'):format(mr))
    return
  end

  mr.refresh(function()
    for _, tool in ipairs(list) do
      local ok_p, p = pcall(mr.get_package, tool)
      if not ok_p then
        log.warn(('mason: unknown package %q'):format(tool))
      elseif not p:is_installed() then
        p:install()
      end
    end
  end)
end

return M
