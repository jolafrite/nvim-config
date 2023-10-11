return function()
  require('conform').setup({
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return { timeout_ms = 1000, lsp_fallback = true, async = false }
    end,
    formatters_by_ft = {
      ['*'] = { 'codespell' },
      ['markdown.mdx'] = { 'my_markdown' },
      css = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
      java = { 'google-java-format' },
      javascript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      lua = { 'stylua' },
      markdown = { 'my_markdown' },
      python = { 'isort', 'black' },
      typescript = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },
    },
    formatters = {
      my_markdown = {
        command = 'markdown-toc',
        args = { '-i', '$FILENAME' },
        stdin = false,
        cwd = require('conform.util').root_file({ '.editorconfig', 'package.json' }),
      },
    },
  })
end
