local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'HiPhish/rainbow-delimiters.nvim',
  lazy = false,
  config = function()
    require('rainbow-delimiters.setup').setup {}

    -- The plugin attaches via its own FileType autocmd, which for any buffer
    -- opened before this config ran has already fired. Attach to every loaded,
    -- normal buffer with a filetype now; pcall guards against filetypes whose
    -- treesitter parser is not installed.
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == '' and vim.bo[bufnr].filetype ~= '' then
        pcall(require('rainbow-delimiters').enable, bufnr)
      end
    end
  end,
}

-- vim: ts=2 sts=2 sw=2 et
