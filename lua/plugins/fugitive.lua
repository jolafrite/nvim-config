return {
  {
    'tpope/vim-fugitive',
    event = 'VimEnter',
    lazy = true,
    cmd = { "Git", "G" },
    dependencies = {
      'tpope/vim-rhubarb',
    }
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = "LazyGit",
  }
}
