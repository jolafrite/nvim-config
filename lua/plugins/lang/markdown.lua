PackageManager.add_with_mason {
  'marksman',
  'markdownlint-cli2',
  'markdown-toc',
}

vim.lsp.config('marksman', {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
})

vim.filetype.add {
  extension = { mdx = 'markdown.mdx' },
}

local conform = require 'conform'
conform.formatters['markdown-toc'] = {
  condition = function(_, ctx)
    for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
      if line:find '<!%-%- toc %-%->' then return true end
    end
  end,
}
conform.formatters_by_ft.markdown = { 'prettierd', 'markdownlint-cli2', 'markdown-toc' }
conform.formatters_by_ft['markdown.mdx'] = { 'prettierd', 'markdownlint-cli2', 'markdown-toc' }

local lint = require 'lint'
lint.linters_by_ft.markdown = { 'markdownlint-cli2' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'markdown', 'markdown_inline' })

vim.lsp.enable 'marksman'
