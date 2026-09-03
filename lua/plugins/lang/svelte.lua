PackageManager.add_with_mason {
  'svelte-language-server',
  'prettierd',
  'oxlint',
}
PackageManager.add_formatter('svelte', 'prettierd')
PackageManager.add_linter('svelte', 'oxlint')

PackageManager.add_snippets 'svelte'

vim.lsp.config('svelte', {
  cmd = function(_, config)
    local cmd = 'svelteserver'
    if config and config.root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
    end
    return vim.lsp.rpc.start({ cmd, '--stdio' }, _)
  end,
  filetypes = { 'svelte' },
})

PackageManager.add_with_treesitter { 'svelte' }

vim.lsp.enable 'svelte'
