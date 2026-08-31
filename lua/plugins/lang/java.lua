local gh = require('utils').gh

PackageManager.add({
  [1] = gh 'mfussenegger/nvim-jdtls',
  filetype = {'java'},
  config = function()

require('utils').install_with_mason {
  'jdtls',
  'google-java-format',
  'checkstyle',
  'java-debug-adapter',
  'java-test',
}

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'java' })

local conform = require 'conform'
conform.formatters.google_java_format = {
  command = 'google-java-format',
  stdin = true,
  args = { '--stdin-path' },
}
conform.formatters_by_ft.java = { 'google_java_format' }

require('lint').linters_by_ft.java = { 'checkstyle' }

-- lombok agent is added when present; -configuration/-data are per-project.
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

-- nvim-jdtls bypasses `vim.lsp.enable`, so attach on FileType java.
require('utils').on_file_types('java', attach_jdtls)

-- vim: ts=2 sts=2 sw=2 et
  end,
})

-- vim: ts=2 sts=2 sw=2 et
