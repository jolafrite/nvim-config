local gh = require('utils').gh

vim.pack.add {
  -- neotest core: required by the neotest-golang/zig/rust adapters and their
  -- health checks (they `require('neotest.lib')` unconditionally).
  gh 'nvim-neotest/neotest',
  gh 'nvim-neotest/nvim-nio',
}
