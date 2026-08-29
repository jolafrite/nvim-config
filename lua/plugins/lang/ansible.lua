-- Ansible language support (treesitter + LSP config, lint).
local gh = require('utils').gh

vim.pack.add {
  gh 'mfussenegger/nvim-ansible',
}

require('utils').install_with_mason {
  'ansible-language-server',
  'ansible-lint',
}

vim.lsp.config('ansiblels', {
  cmd = { 'ansible-language-server', '--stdio' },
  filetypes = { 'yaml.ansible' },
  root_markers = { 'ansible.cfg', '.ansible-lint', '.git' },
})

local lint = require 'lint'
lint.linters_by_ft['yaml.ansible'] = { 'ansible_lint' }

vim.keymap.set('n', '<leader>ta', function()
  pcall(function() require('ansible').run() end)
end, { desc = 'Ansible Run Playbook/Role', silent = true })

vim.lsp.enable 'ansiblels'

-- vim: ts=2 sts=2 sw=2 et
