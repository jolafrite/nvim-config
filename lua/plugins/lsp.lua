local gh = require('utils').gh

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
		-- stylua: ignore
		local keys = {
			{ "<leader>cl", function() Snacks.picker.lsp_config() end,            desc = "Lsp Info" },
			{ "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition",       has = "definition" },
			{ "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
			{ "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
			{ "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
			{ "<leder>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols",           has = "documentSymbol" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
			{ "gai",        function() Snacks.picker.lsp_incoming_calls() end,    desc = "C[a]lls Incoming",      has = "callHierarchy/incomingCalls" },
			{ "gao",        function() Snacks.picker.lsp_outgoing_calls() end,    desc = "C[a]lls Outgoing",      has = "callHierarchy/outgoingCalls" },

			{ "<leader>ca", vim.lsp.buf.code_action,                              desc = "Code Action",           mode = { "n", "x" },                has = "codeAction" },
		}
    for _, key in ipairs(keys) do
      if not key.has or client.supports_method(key.has) then vim.keymap.set('n', key[1], key[2], { desc = key.desc, buffer = bufnr }) end
    end
  end,
}

vim.keymap.set('n', '<leader>ue', '<cmd>LspLensToggle<cr>', { desc = 'Toggle Lsp Lens' })

-- vim: ts=2 sts=2 sw=2 et
