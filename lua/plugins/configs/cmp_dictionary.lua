return function()
  local dict = require('cmp_dictionary')

  dict.setup({})

  dict.switcher({
    spelllang = {
      en = vim.fn.stdpath('config') .. 'dictionaries/en.dict',
      fr = vim.fn.stdpath('config') .. 'dictionaries/fr.dict',
    },
  })
end
