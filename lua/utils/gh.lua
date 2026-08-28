local M = {}

M.gh = function(repo) return 'https://github.com/' .. repo end
M.cb = function(repo) return 'https://codeberg.org/' .. repo end

return M

-- vim: ts=2 sts=2 sw=2 et
