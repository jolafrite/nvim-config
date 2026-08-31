local gh = require('utils').gh

-- Only needed when editing a TS/JS buffer, so load on first FileType.
PackageManager.add {
  [1] = gh 'Sebastian-Nielsen/better-type-hover',
  event = 'FileType',
  config = function()
    local ok, bth = pcall(require, 'better-type-hover')
    if not ok then return end

    bth.config = bth.config or {}
  end,
}
