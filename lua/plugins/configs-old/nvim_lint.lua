return function()
  require('lint').linters_by_ft = {
    bash = { 'shellcheck' },
    clojure = { 'clj-kondo' },
    dockerfile = { 'hadolint' },
    inko = { 'inko' },
    janet = { 'janet' },
    javascript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    json = { 'jsonlint' },
    lua = { 'selene' },
    markdown = { 'vale' },
    python = { 'pylint' },
    rst = { 'vale' },
    ruby = { 'ruby' },
    rust = { 'clippy' },
    sh = { 'shellcheck' },
    svelte = { 'eslint_d' },
    terraform = { 'tflint' },
    text = { 'vale' },
    typescript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    yaml = { 'yamllint' },
    zsh = { 'shellcheck' },
  }
end
