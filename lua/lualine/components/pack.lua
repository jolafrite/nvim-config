-- vim.pack statusline component for lualine.nvim.
--
-- Usage: add { 'pack' } to a lualine section. While a background check runs,
-- shows an animated spinner (kept alive by a small timer that stops itself
-- once the check finishes). When done, shows a package icon and the number of
-- outdated plugins, and renders nothing when everything is up to date.
--
-- Data source: Manager.pack (port of the old plugins.pack engine). The engine
-- announces PackStatusChanged on every state change, which is what drives the
-- redraw here.

local M = require("lualine.component"):extend()

local defaults = {
  icon = "󰏗",
  spinner_frames = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏",
  },
  spinner_interval = 120,
  checking_text = "checking",
}

local frame = 0
local timer
local timer_running = false

-- Animation timer: only ticks while a check is in flight, then stops itself,
-- so it costs nothing when idle.
local function ensure_spinner()
  if timer_running then
    return
  end
  timer_running = true
  timer = vim.uv.new_timer()
  timer:start(
    0,
    defaults.spinner_interval,
    vim.schedule_wrap(function()
      local pack = Manager.pack
      if not (pack and pack.state.checking) then
        timer:stop()
        timer_running = false
        return
      end
      frame = (frame % #defaults.spinner_frames) + 1
      local ok, lualine = pcall(require, "lualine")
      if ok then
        lualine.refresh({ place = { "statusline" } })
      end
    end)
  )
end

local function stop_spinner()
  if timer_running and timer then
    timer:stop()
    timer_running = false
  end
end

function M:init(options)
  options = vim.tbl_deep_extend("force", defaults, options or {})
  M.super.init(self, options)
end

function M:update_status()
  local ok, pack = pcall(function()
    return Manager.pack
  end)
  if not ok or not pack then
    return ""
  end

  local s = pack.summary()

  if s.checking then
    ensure_spinner()
    self.options.icon = defaults.spinner_frames[frame + 1]
      or defaults.spinner_frames[1]
    if s.pending > 0 then
      return ("%d outdated"):format(s.pending)
    end
    return s.status ~= "" and s.status or defaults.checking_text
  end

  stop_spinner()
  frame = 0

  if s.pending > 0 then
    self.options.icon = defaults.icon
    return ("%d"):format(s.pending)
  end

  return ""
end

-- Redraw the statusline when the vim.pack engine reports a state change.
vim.api.nvim_create_autocmd("User", {
  pattern = "PackStatusChanged",
  callback = function()
    vim.schedule(function()
      local ok, lualine = pcall(require, "lualine")
      if ok then
        lualine.refresh({ place = { "statusline" } })
      end
    end)
  end,
})

return M
