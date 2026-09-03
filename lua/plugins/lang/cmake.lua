local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'Civitasv/cmake-tools.nvim',
  filetype = { 'cmake' },
  config = function()
    PackageManager.add_with_mason {
      'neocmakelsp',
      'cmakelang',
      'cmakelint',
    }

    vim.lsp.config('neocmake', {
      cmd = { 'neocmakelsp', 'stdio' },
      filetypes = { 'cmake' },
      root_markers = { '.neocmake.toml', '.git', 'build', 'cmake' },
    })

    PackageManager.add_formatter('cmake', 'cmake_format', function(conform)
      conform.formatters.cmake_format = {
        command = 'cmake-format',
        stdin = true,
      }
    end)

    PackageManager.add_linter('cmake', 'cmakelint')

    PackageManager.add_with_treesitter({ 'cmake' })

    vim.lsp.enable 'neocmake'
  end,
}
