local gh = require('utils').gh

Manager.add({
  [1] = gh 'scalameta/nvim-metals',
  dependencies = {
    gh 'nvim-lua/plenary.nvim'
  },
  filetype = {'scala'},
  config = function()

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
  end,
})

-- vim: ts=2 sts=2 sw=2 et
