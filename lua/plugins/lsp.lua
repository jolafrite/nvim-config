vim.diagnostic.config {
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = '󰗖 ',
      [vim.diagnostic.severity.HINT] = '󰘥 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
    },
  },
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  float = {
    border = 'rounded',
    source = true,
  },
}

vim.lsp.config['*'] = {
  capabilities = (function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.workspace = capabilities.workspace or {}
    capabilities.workspace.fileOperations = {
      didRename = true,
      willRename = true,
    }
    return capabilities
  end)(),

  on_attach = function(client, bufnr)
    local function map(modes, lhs, rhs, desc, method, opts)
      if method and not client:supports_method(method) then return end
      opts = vim.tbl_extend('force', { desc = desc, buffer = bufnr, silent = true }, opts or {})
      vim.keymap.set(modes, lhs, rhs, opts)
    end

    map('n', 'gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition', 'textDocument/definition')

    map('n', 'gr', function() Snacks.picker.lsp_references() end, 'References', 'textDocument/references', { nowait = true })

    map('n', 'gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementation', 'textDocument/implementation')

    map('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, 'Goto T[y]pe Definition', 'textDocument/typeDefinition')

    map('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, 'LSP Symbols', 'textDocument/documentSymbol')

    map('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols', 'workspace/symbol')

    map('n', 'gai', function() Snacks.picker.lsp_incoming_calls() end, 'C[a]lls Incoming', 'callHierarchy/incomingCalls')

    map('n', 'gao', function() Snacks.picker.lsp_outgoing_calls() end, 'C[a]lls Outgoing', 'callHierarchy/outgoingCalls')

    map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, 'Code Action', 'textDocument/codeAction')

    map('n', 'K', vim.lsp.buf.hover, 'Hover', 'textDocument/hover')

    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename', 'textDocument/rename')

    map('n', '<leader>cl', function() Snacks.picker.lsp_config() end, 'Lsp Info')

    map('n', ']d', function() vim.diagnostic.jump { count = 1, float = true } end, 'Next Diagnostic')

    map('n', '[d', function() vim.diagnostic.jump { count = -1, float = true } end, 'Prev Diagnostic')

    map('n', '<leader>q', vim.diagnostic.setloclist, 'Diagnostic List')
  end,
}

vim.keymap.set('n', '<leader>ue', '<cmd>LspLensToggle<cr>', { desc = 'Toggle Lsp Lens' })
