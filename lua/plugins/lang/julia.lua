-- only enabled when a julia binary is available (LanguageServer.jl)
PackageManager.add({
  name = 'lang.julia',
  filetype = { 'julia' },
  config = function()

local julia = vim.fn.executable 'julia' == 1

if julia then
  vim.lsp.config('julials', {
    cmd = { 'julia', '-e', 'using LanguageServer; runserver()' },
    filetypes = { 'julia' },
    root_markers = { 'Project.toml', 'JuliaProject.toml', '.git' },
    settings = {
      julia = {
        completionmode = 'qualify',
        lint = { missingrefs = 'none' },
      },
    },
  })
  vim.lsp.enable 'julials'
end

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'julia' })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
