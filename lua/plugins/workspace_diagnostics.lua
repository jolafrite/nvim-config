local gh = require('utils').gh

-- Workspace-wide diagnostics. Only useful once an LSP is attached, so load
-- on first LspAttach instead of at startup.
PackageManager.add {
  [1] = gh 'artemave/workspace-diagnostics.nvim',
  event = 'LspAttach',
  config = function() require('workspace-diagnostics').setup {} end,
}

-- vim: ts=2 sts=2 sw=2 et
