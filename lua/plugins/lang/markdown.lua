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

PackageManager.add_formatter({ 'markdown', 'markdown.mdx' }, { 'prettierd', 'markdownlint-cli2', 'markdown-toc' }, function(conform)
  conform.formatters['markdown-toc'] = {
    condition = function(_, ctx)
      for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
        if line:find '<!%-%- toc %-%->' then return true end
      end
    end,
  }
end)

PackageManager.add_linter('markdown', 'markdownlint-cli2')

PackageManager.add_with_treesitter { 'markdown', 'markdown_inline' }

vim.lsp.enable 'marksman'
