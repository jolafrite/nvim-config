local gh = require('utils').gh

-- Workspace-wide diagnostics. Only useful once an LSP is attached, so load
-- on first LSPAttach instead of at startup.
require('utils').on_lsp_attach(function()
  vim.pack.add {
    gh 'artemave/workspace-diagnostics.nvim',
  }

  require('workspace-diagnostics').setup {}
end)
