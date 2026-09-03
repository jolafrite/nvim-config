local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'mrcjkb/haskell-tools.nvim',
  filetype = { 'haskell' },
  config = function()
    PackageManager.add_with_mason {
      'haskell-language-server',
      'haskell-debug-adapter',
      'fourmolu',
      'hlint',
    }
    PackageManager.add_formatter('haskell', 'fourmolu')
    PackageManager.add_formatter('cabal', 'cabal_fmt')
    PackageManager.add_linter('haskell', 'hlint')

    PackageManager.add_debugger('haskell', 'haskell-debug-adapter')

    PackageManager.add_snippets 'haskell'

    PackageManager.add_with_treesitter { 'haskell' }

    require('utils').on_file_types({ 'haskell', 'lhaskell' }, function()
      local ok, ht = pcall(require, 'haskell-tools')
      if ok then
        ht.setup {
          hls = {
            on_attach = function(_, bufnr)
              vim.keymap.set('n', '<localleader>e', '<cmd>HlsEvalAll<cr>', { buffer = bufnr, desc = 'Evaluate All' })
              vim.keymap.set(
                'n',
                '<localleader>h',
                function() require('haskell-tools').hoogle.hoogle_signature() end,
                { buffer = bufnr, desc = 'Hoogle Signature' }
              )
              vim.keymap.set('n', '<localleader>r', function() require('haskell-tools').repl.toggle() end, { buffer = bufnr, desc = 'REPL (Package)' })
              vim.keymap.set(
                'n',
                '<localleader>R',
                function() require('haskell-tools').repl.toggle(vim.api.nvim_buf_get_name(0)) end,
                { buffer = bufnr, desc = 'REPL (Buffer)' }
              )
            end,
          },
        }
      end
    end)
  end,
}
