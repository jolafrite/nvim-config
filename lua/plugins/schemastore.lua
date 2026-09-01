local gh = require('utils').gh

-- SchemaStore.nvim is consumed by the config-only LSP wiring in
-- lang/json.lua (jsonls) and lang/yaml.lua (yamlls) — there is no plugin
-- spec for those LSPs to attach a `dependencies` entry to, so this file is
-- the single registration point. Loaded lazily on the filetypes whose LSPs
-- pull schemas from it; the consumers require it inside their LSP
-- `before_init`, which runs after this spec has loaded (phase-1 FileType
-- autocmds fire before phase-2 LSP attach).
PackageManager.add {
  [1] = gh 'b0o/SchemaStore.nvim',
  filetype = { 'json', 'jsonc', 'json5', 'yaml' },
}
