local global = {}
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
  self.is_mac = os_name == 'Darwin'
  self.is_linux = os_name == 'Linux'
  self.is_windows = os_name == 'Windows_NT'
  self.is_wsl = vim.fn.has('wsl') == 1
  self.vim_path = vim.fn.stdpath('config')

  local path_sep = self.is_windows and '\\' or '/'
  local data_dir = string.format('%s/site/', vim.fn.stdpath('data'))
  local home_dir = self.is_windows and os.getenv('USERPROFILE') or os.getenv('HOME')
  local cache_dir = home_dir .. path_sep .. '.cache' .. path_sep .. 'nvim'

  self.backup_dir = cache_dir .. path_sep .. 'backup'
  self.data_dir = data_dir
  self.databases_dir = cache_dir .. path_sep .. 'databases'
  self.home = home_dir
  self.plugins_dir = self.vim_path .. path_sep .. 'lua/plugins'
  self.session_dir = cache_dir .. path_sep .. 'session'
  self.swap_dir = cache_dir .. path_sep .. 'swap'
  self.tags_dir = cache_dir .. path_sep .. 'tags'
  self.templates_dir = self.vim_path .. path_sep .. 'templates'
  self.undo_dir = cache_dir .. path_sep .. 'undo'
end

global:load_variables()

return global
