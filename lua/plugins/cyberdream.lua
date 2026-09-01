local gh = require('utils').gh

-- Inactive theme: lazy-load on the first :cmdline use instead of parsing it
-- at startup next to the active shades-of-purple.
PackageManager.add {
  [1] = gh 'scottmckendry/cyberdream.nvim',
  event = { event = 'CmdlineEnter', pattern = ':' },
}
