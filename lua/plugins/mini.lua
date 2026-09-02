local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'nvim-mini/mini.nvim',
  dependencies = {
    gh 'nvim-mini/mini.diff',
    gh 'nvim-mini/mini.operators',
    gh 'nvim-mini/mini.pairs',
    gh 'nvim-mini/mini.surround',
    gh 'nvim-mini/mini.icons',
    gh 'nvim-mini/mini.visits',
    gh 'nvim-mini/mini.files',
  },
  lazy = false,
  config = function()
    require('mini.diff').setup {
      view = {
        style = 'sign',
        signs = {
          add = '▎',
          change = '▎',
          delete = '',
        },
      },
    }

    require('mini.surround').setup {
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        update_n_lines = 'gsn',
      },
    }

    require('mini.files').setup {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      options = {
        use_as_default_explorer = false,
      },
    }

    require('mini.icons').setup {
      file = {
        ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
        ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
      filetype = {
        dotenv = { glyph = '', hl = 'MiniIconsYellow' },
        gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
      },
    }

    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}

