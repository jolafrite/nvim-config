-- mdx files map to markdown.mdx so marksman, conform and nvim-lint all engage.
vim.filetype.add {
  extension = { mdx = 'markdown.mdx' },
}

require('utils').install_with_mason {
  'marksman',
  'markdownlint-cli2',
  'markdown-toc',
}

vim.lsp.config('marksman', {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
})

local conform = require 'conform'
-- Only run markdown-toc when the file declares a `<!-- toc -->` marker.
conform.formatters['markdown-toc'] = {
  condition = function(_, ctx)
    for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
      if line:find '<!%-%- toc %-%->' then return true end
    end
  end,
}
conform.formatters_by_ft.markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' }
conform.formatters_by_ft['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' }

local lint = require 'lint'
lint.linters_by_ft.markdown = { 'markdownlint-cli2' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'markdown', 'markdown_inline' })

vim.lsp.enable 'marksman'

-- vim: ts=2 sts=2 sw=2 et
