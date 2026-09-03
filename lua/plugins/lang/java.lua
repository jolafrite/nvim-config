local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'mfussenegger/nvim-jdtls',
  filetype = { 'java' },
  config = function()
    PackageManager.add_with_mason {
      'jdtls',
      'google-java-format',
      'checkstyle',
      'java-debug-adapter',
      'java-test',
    }

    PackageManager.add_with_treesitter { 'java' }

    -- conform's built-in google-java-format config is correct (`-` + stdin);
    -- a custom override with `--stdin-path` makes the binary print usage.
    PackageManager.add_formatter('java', 'google-java-format')

    PackageManager.add_linter('java', 'checkstyle')

    PackageManager.add_debugger('java', 'java-debug-adapter')

    PackageManager.add_snippets 'java'

    local function jdtls_cmd(root_dir)
      local cmd = { vim.fn.exepath 'jdtls' or 'jdtls' }
      if vim.env.MASON then
        local lombok = vim.env.MASON .. '/share/jdtls/lombok.jar'
        if vim.fn.filereadable(lombok) == 1 then vim.list_extend(cmd, { '--jvm-arg=-javaagent:' .. lombok }) end
      end
      local project_name = vim.fs.basename(root_dir)
      local workspaces = vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name
      vim.list_extend(cmd, { '-configuration', workspaces .. '/config', '-data', workspaces .. '/data' })
      return cmd
    end

    local function attach_jdtls()
      local ok, jdtls = pcall(require, 'jdtls')
      if not ok then return end

      local fname = vim.api.nvim_buf_get_name(0)
      local root_markers = {
        'build.gradle',
        'build.gradle.kts',
        'build.xml',
        'pom.xml',
        'settings.gradle',
        'settings.gradle.kts',
        '.git',
      }
      local root_dir = vim.fs.root(fname, root_markers) or vim.fn.getcwd()

      jdtls.start_or_attach {
        cmd = jdtls_cmd(root_dir),
        root_dir = root_dir,
        settings = {
          java = {
            inlayHints = {
              parameterNames = {
                enabled = 'all',
              },
            },
          },
        },
        on_attach = function(_, bufnr)
          local wk = require 'which-key'
          wk.add {
            {
              mode = 'n',
              buffer = bufnr,
              { '<leader>cx', group = 'extract' },
              { '<leader>cxv', jdtls.extract_variable_all, desc = 'Extract Variable' },
              { '<leader>cxc', jdtls.extract_constant, desc = 'Extract Constant' },
              { '<leader>cgs', jdtls.super_implementation, desc = 'Goto Super' },
              { '<leader>co', jdtls.organize_imports, desc = 'Organize Imports' },
            },
          }
          wk.add {
            {
              mode = 'x',
              buffer = bufnr,
              { '<leader>cx', group = 'extract' },
              { '<leader>cxm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], desc = 'Extract Method' },
              { '<leader>cxv', [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]], desc = 'Extract Variable' },
              { '<leader>cxc', [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]], desc = 'Extract Constant' },
            },
          }
        end,
      }
    end

    require('utils').on_file_types('java', attach_jdtls)

    -- The autocmd above is registered from within the first java FileType
    -- event, so it cannot fire for the buffer that triggered it. Attach
    -- that buffer directly; later buffers go through on_file_types.
    if vim.bo.filetype == 'java' then attach_jdtls() end
  end,
}
