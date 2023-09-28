return {
  {
    'iamcco/markdown-preview.nvim',
    ft = "markdown",
    build = ":call mkdp#util#install()",
    -- using npm to install rather than the vim function leads to significantly faster startup time
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    config = function()
      vim.keymap.set('n', '<leader>m', '<Plug>MarkdownPreviewToggle', { desc = 'Markdown Preview' })
    end
  },
  {
    "dkarter/bullets.vim",
    lazy = true,
    ft = "markdown"
  }
}
