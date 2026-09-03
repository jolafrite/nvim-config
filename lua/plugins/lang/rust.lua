local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'mrcjkb/rustaceanvim',
  dependencies = {
    gh 'Saecki/crates.nvim',
  },
  filetype = { 'rust' },
  config = function()
    PackageManager.add_with_mason {
      'rust-analyzer',
      'codelldb',
    }
    PackageManager.add_debugger('rust', 'codelldb')

    PackageManager.add_with_treesitter { 'rust' }

    local diagnostics = vim.g.lazyvim_rust_diagnostics or 'rust-analyzer'

    if diagnostics == 'bacon-ls' then
      PackageManager.add_with_mason {
        'bacon',
      }
      vim.lsp.config('bacon_ls', {
        cmd = { 'bacon-ls' },
        filetypes = { 'rust' },
      })
      vim.lsp.enable 'bacon_ls'
    end

    vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>cR', function() vim.cmd.RustLsp 'codeAction' end, { desc = 'Code Action', buffer = bufnr })
          vim.keymap.set('n', '<leader>dr', function() vim.cmd.RustLsp 'debuggables' end, { desc = 'Rust Debuggables', buffer = bufnr })
        end,
        default_settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },
            checkOnSave = diagnostics == 'rust-analyzer',
            diagnostics = { enable = diagnostics == 'rust-analyzer' },
            procMacro = { enable = true },
            files = {
              exclude = {
                '.direnv',
                '.git',
                '.jj',
                '.github',
                '.gitlab',
                'bin',
                'node_modules',
                'target',
                'venv',
                '.venv',
              },

              watcher = 'client',
            },
          },
        },
      },
    })

    require('crates').setup()

    if vim.bo.filetype == 'rust' then pcall(function() require('rustaceanvim.lsp').start(vim.api.nvim_get_current_buf()) end) end

    PackageManager.add_formatter(
      'rust',
      'rustfmt',
      function(conform)
        conform.formatters.rustfmt = {
          command = 'rustfmt',
          stdin = true,
          args = { '--emit=stdout' },
        }
      end
    )

    PackageManager.add_linter('rust', 'clippy')

    require('lint').linters.clippy = vim.tbl_deep_extend('force', require('lint').linters.clippy, { ignore_exitcode = true })

    PackageManager.add_snippets 'rust'

    PackageManager.add_tester('rust', { ['rustaceanvim.neotest'] = {} })
  end,
}
