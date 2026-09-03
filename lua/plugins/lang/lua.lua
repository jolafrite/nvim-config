PackageManager.add_with_mason {
  'lua-language-server',
  'stylua',
  'selene',
}

PackageManager.add_with_treesitter { 'lua', 'luadoc', 'luap' }

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },

  on_init = function(client) client.server_capabilities.documentFormattingProvider = false end,

  settings = {
    Lua = {
      signatureHelp = { enabled = true },
      format = { enable = false },
      codeLens = { enable = true },
      hint = { enable = true },
    },
  },
})

PackageManager.add_formatter('lua', 'stylua')

PackageManager.add_snippets 'lua'
PackageManager.add_linter('lua', 'selene', function(lint)
  if vim.uv.fs_stat(vim.fn.expand '~/.cargo/bin/selene') then lint.linters.selene.cmd = vim.fn.expand '~/.cargo/bin/selene' end
end)

vim.lsp.enable 'lua_ls'
