-- Scala language support (nvim-metals).
--
-- nvim-metals manages the Metals LSP lifecycle itself (via coursier), so
-- no `vim.lsp.config`/`vim.lsp.enable` is needed here. attach happens on
-- FileType scala/sbt.
local gh = require('utils').gh

vim.pack.add {
  gh 'scalameta/nvim-metals',
  gh 'nvim-lua/plenary.nvim',
}

-- Tree-sitter parser for Scala.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'scala' })

local ok, metals = pcall(require, 'metals')
if ok then
  local metals_config = metals.bare_config()

  metals_config.init_options.statusBarProvider = 'off'

  metals_config.settings = {
    verboseCompilation = true,
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    superMethodLensesEnabled = true,
    excludedPackages = {
      'akka.actor.typed.javadsl',
      'org.apache.pekko.actor.typed.javadsl',
      'com.github.swagger.akka.javadsl',
    },
    testUserInterface = 'Test Explorer',
  }

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'scala', 'sbt' },
    callback = function() metals.initialize_or_attach(metals_config) end,
  })
end

-- vim: ts=2 sts=2 sw=2 et
