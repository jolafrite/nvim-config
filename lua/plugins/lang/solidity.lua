

PackageManager.add_with_mason {
  'solidity',
}
PackageManager.add_formatter('solidity', 'forge_fmt', function(conform)
  conform.formatters.forge_fmt = {
    condition = function() return vim.fn.executable 'forge' == 1 end,
  }
end)

if vim.fn.executable 'solc' == 1 then
  vim.lsp.config('solidity_ls', {
    cmd = { 'solc', '--lsp' },
    filetypes = { 'solidity' },
    root_markers = {
      'foundry.toml',
      'hardhat.config.js',
      'hardhat.config.ts',
      '.git',
    },
  })
  vim.lsp.enable 'solidity_ls'
end

PackageManager.add_with_treesitter { 'solidity' }
