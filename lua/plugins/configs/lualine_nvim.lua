local function is_available_lspsaga()
  local ok, _ = pcall(require, 'lspsaga')
  return ok
end

local function esc(x)
  return (
    x:gsub('%%', '%%%%')
      :gsub('^%^', '%%^')
      :gsub('%$$', '%%$')
      :gsub('%(', '%%(')
      :gsub('%)', '%%)')
      :gsub('%.', '%%.')
      :gsub('%[', '%%[')
      :gsub('%]', '%%]')
      :gsub('%*', '%%*')
      :gsub('%+', '%%+')
      :gsub('%-', '%%-')
      :gsub('%?', '%%?')
  )
end

local function get_cwd()
  local cwd = vim.uv.cwd()
  local git_dir = require('lualine.components.branch.git_branch').find_git_dir(cwd)
  local root = vim.fs.dirname(git_dir)
  if cwd == root then
    return ''
  end

  local d, n = string.gsub(cwd, esc(root) .. '/', '')
  if n == 0 and d == nil then
    return ''
  end
  return '(./' .. d .. ')'
end

local function selected_line()
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'v' or mode == 'V' then
    return '(' .. vim.fn.abs(vim.fn.line('.') - vim.fn.line('v')) + 1 .. ')'
  end
  return ''
end

local sections_1 = {
  lualine_a = { 'mode' },
  lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 1 }, { get_cwd } },
  lualine_c = { { 'require("lspsaga.symbolwinbar"):get_winbar()', cond = is_available_lspsaga } },
  lualine_x = { "require'lsp-status'.status()", 'diagnostics', 'overseer' },
  lualine_y = { 'branch', 'diff' },
  lualine_z = { 'location', selected_line },
}

local sections_2 = {
  lualine_a = { 'mode' },
}

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = sections_1,
  inactive_sections = {
    lualine_a = { 'mode' },
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {
    'quickfix',
    'symbols-outline',
    { sections = { lualine_b = { 'filetype' } }, filetypes = { 'packager', 'vista', 'NvimTree', 'coc-explorer' } },
  },
})
