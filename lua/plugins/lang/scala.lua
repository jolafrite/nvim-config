local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'scalameta/nvim-metals',
  dependencies = {
    gh 'nvim-lua/plenary.nvim',
  },
  filetype = { 'scala' },
  config = function()
    PackageManager.add_with_treesitter { 'scala' }

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

      local attach = function() metals.initialize_or_attach(metals_config) end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('nvim_metals', { clear = true }),
        pattern = { 'scala', 'sbt' },
        callback = attach,
      })

      -- This spec is loaded from the first `scala` FileType event, so the
      -- autocmd above cannot fire for the buffer that triggered it. Attach
      -- that buffer directly; later buffers go through the autocmd.
      if vim.list_contains({ 'scala', 'sbt' }, vim.bo.filetype) then attach() end
    end
  end,
}
