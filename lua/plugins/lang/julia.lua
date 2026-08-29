-- Julia language support (treesitter + LSP config).
--
-- The Julia LSP runs `julia` with the LanguageServer.jl package, so it is
-- only enabled when a `julia` binary is available.
local julia = vim.fn.executable 'julia' == 1

if julia then
  vim.lsp.config('julials', {
    cmd = { 'julia', '-e', 'using LanguageServer; runserver()' },
    filetypes = { 'julia' },
    root_markers = { 'Project.toml', 'JuliaProject.toml', '.git' },
    settings = {
      julia = {
        -- same defaults as the Julia VS Code extension
        completionmode = 'qualify',
        lint = { missingrefs = 'none' },
      },
    },
  })
  vim.lsp.enable 'julials'
end

-- Tree-sitter parser for Julia.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'julia', 'julia_manual', 'julia_site', 'julia_markdown' })

-- vim: ts=2 sts=2 sw=2 et
