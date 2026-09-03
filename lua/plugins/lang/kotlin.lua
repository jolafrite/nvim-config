local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'AlexandrosAlexiou/kotlin.nvim',
  filetype = { 'kotlin' },
  config = function()
    PackageManager.add_with_mason {
      'kotlin-language-server',
      'ktfmt',
      'ktlint',
      'kotlin-debug-adapter',
    }
    PackageManager.add_formatter('kotlin', 'ktlint')
    PackageManager.add_linter('kotlin', 'ktlint')

    PackageManager.add_debugger('kotlin', 'kotlin-debug-adapter')

    PackageManager.add_snippets 'kotlin'

    vim.lsp.config('kotlin_language_server', {
      cmd = { 'kotlin-language-server' },
      filetypes = { 'kotlin' },
    })

    PackageManager.add_with_treesitter { 'kotlin' }

    vim.lsp.enable 'kotlin_language_server'

    pcall(function()
      local dap = require 'dap'
      if not dap.adapters.kotlin then
        dap.adapters.kotlin = {
          type = 'executable',
          command = 'kotlin-debug-adapter',
          options = { auto_continue_if_many_stopped = false },
        }
      end

      dap.configurations.kotlin = {
        {
          type = 'kotlin',
          request = 'launch',
          name = 'This file',
          mainClass = function()
            local root = vim.fs.find('src', { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ''
            local fname = vim.api.nvim_buf_get_name(0)
            return fname:gsub(root, ''):gsub('main/kotlin/', ''):gsub('.kt', 'Kt'):gsub('/', '.'):sub(2, -1)
          end,
          projectRoot = '${workspaceFolder}',
          jsonLogFile = '',
          enableJsonLogging = false,
        },
        {
          type = 'kotlin',
          request = 'attach',
          name = 'Attach to debugging session',
          port = 5005,
          args = {},
          projectRoot = function() return vim.fn.getcwd() end,
          hostName = 'localhost',
          timeout = 2000,
        },
      }
    end)
  end,
}
