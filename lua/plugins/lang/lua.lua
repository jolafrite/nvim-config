PackageManager.add_with_mason {
  'lua-language-server',
  'stylua',
  'selene',
}

pcall(function() require('nvim-treesitter').install { 'lua', 'luadoc', 'luap' } end)

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
PackageManager.add_linter('lua', 'selene')

if vim.uv.fs_stat(vim.fn.expand '~/.cargo/bin/selene') then lint.linters.selene.cmd = vim.fn.expand '~/.cargo/bin/selene' end

vim.lsp.enable 'lua_ls'
