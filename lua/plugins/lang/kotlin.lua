local gh = require('utils').gh

vim.pack.add {
  gh 'AlexandrosAlexiou/kotlin.nvim',
}

require('utils').install_with_mason {
  'kotlin-language-server',
  'ktfmt',
  'ktlint',
  'kotlin-debug-adapter',
}

vim.lsp.config('kotlin_language_server', {
  cmd = { 'kotlin-language-server' },
  filetypes = { 'kotlin' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'kotlin' })

local conform = require 'conform'
conform.formatters_by_ft.kotlin = { 'ktlint' }

require('lint').linters_by_ft.kotlin = { 'ktlint' }

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
        -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
        return fname:gsub(root, ''):gsub('main/kotlin/', ''):gsub('.kt', 'Kt'):gsub('/', '.'):sub(2, -1)
      end,
      projectRoot = '${workspaceFolder}',
      jsonLogFile = '',
      enableJsonLogging = false,
    },
    {
      -- Use this for unit tests. First run
      -- ./gradlew --info cleanTest test --debug-jvm
      -- then attach the debugger to it.
      type = 'kotlin',
      request = 'attach',
      name = 'Attach to debugging session',
      port = 5005,
      args = {},
      projectRoot = vim.fn.getcwd,
      hostName = 'localhost',
      timeout = 2000,
    },
  }
end)

-- vim: ts=2 sts=2 sw=2 et
