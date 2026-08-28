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

-- Safely merge blink.cmp capabilities when available
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, 'blink.cmp')
if ok_blink and blink.get_lsp_capabilities then
  capabilities = vim.tbl_deep_extend('force', capabilities, blink.get_lsp_capabilities())
end
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.fileOperations = {
  didRename = true,
  willRename = true,
}

vim.lsp.config['*'] = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
		-- stylua: ignore
		local keys = {
			{ "<leader>cl", function() vim.lsp.status() end,                                                 desc = "Lsp Info" },
			{ "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition",       has = "definition" },
			{ "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
			{ "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
			{ "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols",           has = "documentSymbol" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
			{ "gai",        function() Snacks.picker.lsp_incoming_calls() end,    desc = "C[a]lls Incoming",      has = "callHierarchy/incomingCalls" },
			{ "gao",        function() Snacks.picker.lsp_outgoing_calls() end,    desc = "C[a]lls Outgoing",      has = "callHierarchy/outgoingCalls" },

			{ "<leader>ca", vim.lsp.buf.code_action,                              desc = "Code Action",           mode = { "n", "x" },                has = "codeAction" },
		}
    for _, key in ipairs(keys) do
      if not key.has or client.supports_method(key.has) then
        local mode = key.mode or 'n'
        local opts = { desc = key.desc, buffer = bufnr }
        if key.nowait then opts.nowait = true end
        vim.keymap.set(mode, key[1], key[2], opts)
      end
    end
  end,
}

vim.keymap.set('n', '<leader>ue', function()
  if vim.fn.exists(':LspLensToggle') > 0 then
    vim.cmd('LspLensToggle')
  else
    vim.notify('LspLens is not available', vim.log.levels.WARN)
  end
end, { desc = 'Toggle Lsp Lens' })

-- vim: ts=2 sts=2 sw=2 et
