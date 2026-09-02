local gh = require('utils').gh








PackageManager.add {
  [1] = gh 'b0o/SchemaStore.nvim',
  filetype = { 'json', 'jsonc', 'json5', 'yaml' },
}
