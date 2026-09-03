local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'scalameta/nvim-metals',
  dependencies = {
    gh 'nvim-lua/plenary.nvim',
  },
  filetype = { 'scala' },
  config = function()
    PackageManager.add_with_treesitter({ 'scala' })

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
  end,
}
