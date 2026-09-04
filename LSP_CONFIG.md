# LSP Config Reference

Based on [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/tree/master/lsp). All servers not marked "deprecated". This file was generated from inspecting the nvim-lspconfig source directly and parsing the server configurations into a reference table. The "Config" column renders key Lua fields that you would typically use when calling `vim.lsp.config(name, {...})` or passing to the old `lspconfig[name].setup({...})`.

| Language(s) | LSP Server | Config |
| --- | --- | --- |
| foam, OpenFOAM | foam-ls | `cmd = { 'foam-ls', '--stdio' }, filetypes = {'foam', 'OpenFOAM'}, root_dir = function(...) end` |
| templ | templ | `cmd = { 'templ', 'lsp' }, filetypes = {'templ'}, root_markers = {'go.work', 'go.mod', '.git'}` |
| hlasm | hlasm_language_server | `cmd = { 'hlasm_language_server' }, filetypes = {'hlasm'}, root_markers = {'.hlasmplugin'}` |
| tabby_ml | tabby-agent | `cmd = { 'tabby-agent', '--lsp', '--stdio' }, filetypes = {}, root_markers = {'.git'}` |
| scala | metals | `cmd = { 'metals' }, filetypes = {'scala'}, root_markers = {'build.sbt', 'build.sc', {'build.gradle', 'build.gradle.kts'}}, init_options = {...}` |
| coffee | coffeesense-language-server | `cmd = { 'coffeesense-language-server', '--stdio' }, filetypes = {'coffee'}, root_markers = {'package.json'}` |
| fennel | fennel-ls | `cmd = { 'fennel-ls' }, filetypes = {'fennel'}, settings = {...}, root_dir = function(...) end` |
| gdshader, gdshaderinc | gdshader-lsp | `cmd = { 'gdshader-lsp', '--stdio' }, filetypes = {'gdshader', 'gdshaderinc'}, root_markers = {'project.godot'}` |
| dts | ginko_ls | `cmd = { 'ginko_ls' }, filetypes = {'dts'}, root_markers = {'.git'}, settings = {...}` |
| cue | cuelsp | `cmd = { 'cuelsp' }, filetypes = {'cue'}, root_markers = {'cue.mod', '.git'}` |
| ruby | stree | `cmd = { 'stree', 'lsp' }, filetypes = {'ruby'}, root_markers = {'.streerc', 'Gemfile', '.git'}` |
| sls | salt_lsp_server | `cmd = { 'salt_lsp_server' }, filetypes = {'sls'}, root_markers = {'.git'}` |
| openscad | openscad-lsp | `cmd = { 'openscad-lsp', '--stdio' }, filetypes = {'openscad'}, root_markers = {'.git'}` |
| bsl, os | bsl_ls | `filetypes = {'bsl', 'os'}, root_markers = {'.git'}` |
| html, antlers | antlersls | `cmd = { 'antlersls', '--stdio' }, filetypes = {'html', 'antlers'}, root_markers = {'composer.json'}` |
| php | intelephense | `cmd = { 'intelephense', '--stdio' }, filetypes = {'php'}, root_markers = {'.git', 'composer.json'}, settings = {...}` |
| fstar | fstar.exe | `cmd = { 'fstar.exe', '--lsp' }, filetypes = {'fstar'}, root_markers = {'.git'}` |
| html | html | `cmd = function(dispatchers), filetypes = {'html'}, root_markers = {'package.json', '.git'}, settings = {...}, init_options = {...}` |
| html, ruby, eruby, blade, php | turbo-language-server | `cmd = { 'turbo-language-server', '--stdio' }, filetypes = {'html', 'ruby', 'eruby', 'blade', 'php'}, root_markers = {'Gemfile', '.git'}` |
| qml, qmljs | qmlls | `cmd = { 'qmlls' }, filetypes = {'qml', 'qmljs'}, root_markers = {'.git'}` |
| terraform | ms-terraform-lsp | `cmd = { 'ms-terraform-lsp', 'serve' }, filetypes = {'terraform'}, root_markers = {'.terraform', '.git'}` |
| javascript, javascriptreact, typescript, typescriptreact, vue, svelte, astro, htmlangular | eslint | `cmd = function(dispatchers), filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'astro', 'htmlangular'}, root_markers = {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock'}, settings = {...}, root_dir = function(...) end` |
| javascript, javascriptreact, typescript, typescriptreact, toml, json, jsonc, json5, yaml, html, vue, handlebars, css, scss, less, graphql, markdown, svelte | oxfmt | `cmd = function(dispatchers), filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'toml', 'json', 'jsonc', 'json5', 'yaml', 'html', 'vue', 'handlebars', 'css', 'scss', 'less', 'graphql', 'markdown', 'svelte'}, root_dir = function(...) end` |
| blueprint | blueprint-compiler | `cmd = { 'blueprint-compiler', 'lsp' }, filetypes = {'blueprint'}, root_markers = {'.git'}` |
| toml | taplo | `cmd = { 'taplo', 'lsp', 'stdio' }, filetypes = {'toml'}, root_markers = {'.taplo.toml', 'taplo.toml', '.git'}` |
| brioche | brioche | `cmd = { 'brioche', 'lsp' }, filetypes = {'brioche'}, root_markers = {'project.bri'}` |
| crystal | crystalline | `cmd = { 'crystalline' }, filetypes = {'crystal'}, root_markers = {'shard.yml', '.git'}` |
| c, c.doxygen, cpp, cpp.doxygen, objc, objcpp, cuda | clangd | `cmd = { 'clangd' }, filetypes = {'c', 'c.doxygen', 'cpp', 'cpp.doxygen', 'objc', 'objcpp', 'cuda'}, root_markers = {'.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git'}` |
| gn | gnls | `cmd = { 'gnls', '--stdio' }, filetypes = {'gn'}, root_markers = {'.gn', '.git'}` |
| koka | koka | `cmd = { 'koka', '--language-server', '--lsstdio' }, filetypes = {'koka'}, root_markers = {'.git'}` |
| apex, apexcode, c, cpp, cs, dart, dockerfile, elixir, eelixir, go, gomod, groovy, helm, java, javascript, json, kotlin, objc, objcpp, php, python, requirements, ruby, rust, scala, swift, terraform, terraform-vars, typescript, yaml | snyk | `cmd = { 'snyk', 'language-server', '-l', 'info' }, filetypes = {'apex', 'apexcode', 'c', 'cpp', 'cs', 'dart', 'dockerfile', 'elixir', 'eelixir', 'go', 'gomod', 'groovy', 'helm', 'java', 'javascript', 'json', 'kotlin', 'objc', 'objcpp', 'php', 'python', 'requirements', 'ruby', 'rust', 'scala', 'swift', 'terraform', 'terraform-vars', 'typescript', 'yaml'}, root_markers = {'.git', '.snyk'}, settings = {...}, init_options = {...}` |
| html, htmldjango | djlsp | `cmd = { 'djlsp' }, filetypes = {'html', 'htmldjango'}, root_markers = {'.git'}, settings = {...}` |
| haskell, lhaskell | ghcide | `cmd = { 'ghcide', '--lsp' }, filetypes = {'haskell', 'lhaskell'}, root_markers = {'stack.yaml', 'hie-bios', 'BUILD.bazel', 'cabal.config', 'package.yaml'}` |
| smithy | cs | `cmd = { 'cs', 'launch', '--contrib', 'smithy-language-server:0.8.0' }, filetypes = {'smithy'}, root_markers = {'smithy-build.json', 'build.gradle', 'build.gradle.kts', '.git'}, init_options = {...}` |
| astro, css, eruby, html, htmlangular, htmldjango, javascriptreact, less, pug, sass, scss, svelte, templ, typescriptreact, vue | emmet-ls | `cmd = { 'emmet-ls', '--stdio' }, filetypes = {'astro', 'css', 'eruby', 'html', 'htmlangular', 'htmldjango', 'javascriptreact', 'less', 'pug', 'sass', 'scss', 'svelte', 'templ', 'typescriptreact', 'vue'}, root_markers = {'.git'}` |
| puppet | puppet-languageserver | `cmd = { 'puppet-languageserver', '--stdio' }, filetypes = {'puppet'}, root_markers = {'manifests', '.puppet-lint.rc', 'hiera.yaml', '.git'}` |
| sql | bqls | `cmd = { 'bqls' }, filetypes = {'sql'}, root_markers = {'.git'}, settings = {...}` |
| pact | pact-lsp | `cmd = { 'pact-lsp' }, filetypes = {'pact'}, root_markers = {'.git'}` |
| verilog, systemverilog | svls | `cmd = { 'svls' }, filetypes = {'verilog', 'systemverilog'}, root_markers = {'.git'}` |
| markdown | markdown-oxide | `cmd = { 'markdown-oxide' }, filetypes = {'markdown'}, root_markers = {'.git', '.obsidian', '.moxide.toml'}` |
| scheme | scheme-langserver | `cmd = { 'scheme-langserver', '~/.scheme-langserver.log', 'enable', 'disable' }, filetypes = {'scheme'}, root_markers = {'Akku.manifest', '.git'}` |
| glsl, vert, tesc, tese, frag, geom, comp | glslls | `cmd = { 'glslls', '--stdin' }, filetypes = {'glsl', 'vert', 'tesc', 'tese', 'frag', 'geom', 'comp'}, root_markers = {'.git'}` |
| yaml | hydra-lsp | `cmd = { 'hydra-lsp' }, filetypes = {'yaml'}, root_markers = {'.git'}` |
| bzl | buck2 | `cmd = { 'buck2', 'lsp' }, filetypes = {'bzl'}, root_markers = {'.buckconfig'}` |
| scheme.guile | guile-lsp-server | `cmd = { 'guile-lsp-server' }, filetypes = {'scheme.guile'}, root_markers = {'guix.scm', '.git'}` |
| odin | ols | `cmd = { 'ols' }, filetypes = {'odin'}, root_dir = function(...) end` |
| efm | efm-langserver | `cmd = { 'efm-langserver' }, root_markers = {'.git'}` |
| unison | nc | `cmd = { 'nc', 'localhost', os.getenv('UNISON_LSP_PORT') or '5757' }, filetypes = {'unison'}, settings = {...}, root_dir = function(...) end` |
| vhdl, verilog, systemverilog | hdl_checker | `cmd = { 'hdl_checker', '--lsp' }, filetypes = {'vhdl', 'verilog', 'systemverilog'}, root_markers = {'.git'}` |
| bash, sh | bash-language-server | `cmd = { 'bash-language-server', 'start' }, filetypes = {'bash', 'sh'}, root_markers = {'.git'}, settings = {...}` |
| bzl | bzl | `cmd = { 'bzl', 'lsp', 'serve' }, filetypes = {'bzl'}, root_markers = {'WORKSPACE', 'WORKSPACE.bazel'}` |
| lua | lua-language-server | `cmd = { 'lua-language-server' }, filetypes = {'lua'}, settings = {...}` |
| cairo | scarb | `cmd = { 'scarb', 'cairo-language-server', '/C', '--node-ipc' }, filetypes = {'cairo'}, root_markers = {'Scarb.toml', 'cairo_project.toml', '.git'}, init_options = {...}` |
| sql | postgres-language-server | `cmd = { 'postgres-language-server', 'lsp-proxy' }, filetypes = {'sql'}, root_markers = {'postgres-language-server.jsonc'}` |
| systemverilog, verilog | slang-server | `cmd = { 'slang-server' }, filetypes = {'systemverilog', 'verilog'}` |
| d | serve-d | `cmd = { 'serve-d' }, filetypes = {'d'}, root_markers = {'dub.json', 'dub.sdl', '.git'}` |
| ada | ada_language_server | `cmd = { 'ada_language_server' }, filetypes = {'ada'}, root_dir = function(...) end` |
| php | phpantom_lsp | `cmd = { 'phpantom_lsp' }, filetypes = {'php'}, root_markers = {'.phpantom.toml', '.git', 'composer.json'}` |
| gleam | gleam | `cmd = { 'gleam', 'lsp' }, filetypes = {'gleam'}, root_markers = {'gleam.toml', '.git'}` |
| nix | rnix-lsp | `cmd = { 'rnix-lsp' }, filetypes = {'nix'}, settings = {...}, init_options = {...}, root_dir = function(...) end` |
| markdown, markdown.mdx | marksman | `cmd = { 'marksman', 'server' }, filetypes = {'markdown', 'markdown.mdx'}, root_markers = {'.marksman.toml', '.git'}` |
| aiken | aiken | `cmd = { 'aiken', 'lsp' }, filetypes = {'aiken'}, root_markers = {'aiken.toml', '.git'}` |
| javascript, javascriptreact, json, typescript, typescriptreact | rome | `cmd = function(dispatchers), filetypes = {'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact'}, root_markers = {'package.json', 'node_modules', '.git'}` |
| vim | vim-language-server | `cmd = { 'vim-language-server', '--stdio' }, filetypes = {'vim'}, root_markers = {'.git'}, init_options = {...}` |
| asm, vmasm | asm-lsp | `cmd = { 'asm-lsp' }, filetypes = {'asm', 'vmasm'}, root_markers = {'.asm-lsp.toml', '.git'}` |
| fortran | fortls | `cmd = { 'fortls', '--notify_init', '--hover_signature', '--hover_language=fortran', '--use_signature_help' }, filetypes = {'fortran'}, root_markers = {'.fortls', '.fortlsrc', '.fortls.json', '.git'}, settings = {...}` |
| xml, xsd, xsl, xslt, svg | lemminx | `cmd = { 'lemminx' }, filetypes = {'xml', 'xsd', 'xsl', 'xslt', 'svg'}, root_markers = {'.git'}` |
| wat | wat_server | `cmd = { 'wat_server' }, filetypes = {'wat'}` |
| dhall | dhall-lsp-server | `cmd = { 'dhall-lsp-server' }, filetypes = {'dhall'}, root_markers = {'.git'}` |
| java | jdtls | `cmd = function(dispatchers), filetypes = {'java'}, init_options = {...}` |
| coq | coq-lsp | `cmd = { 'coq-lsp' }, filetypes = {'coq'}, root_markers = {'_CoqProject', '.git'}` |
| tablegen | tblgen-lsp-server | `cmd = get_command(), filetypes = {'tablegen'}, root_markers = {'tablegen_compile_commands.yml', '.git'}` |
| gn | gn-language-server | `cmd = { 'gn-language-server', '--stdio' }, filetypes = {'gn'}, root_markers = {'.gn', '.git'}` |
| uvl | uvls | `cmd = { 'uvls' }, filetypes = {'uvl'}, root_markers = {'.git'}` |
| terraform, hcl | terraform-lsp | `cmd = { 'terraform-lsp' }, filetypes = {'terraform', 'hcl'}, root_markers = {'.terraform', '.git'}` |
| systemd | systemd-lsp | `cmd = { 'systemd-lsp' }, filetypes = {'systemd'}` |
| typescript, html, typescriptreact, htmlangular | angularls | `cmd = function(dispatchers), filetypes = {'typescript', 'html', 'typescriptreact', 'htmlangular'}, root_markers = {'angular.json', 'nx.json'}` |
| cs | Microsoft.CodeAnalysis.LanguageServer | `cmd = { vim.fn.executable('Microsoft.CodeAnalysis.LanguageServer') == 1 and 'Microsoft.CodeAnalysis.LanguageServer' or 'roslyn-language-server', '--stdio' }, filetypes = {'cs'}, settings = {...}, root_dir = function(...) end` |
| javascript, typescript, javascriptreact, typescriptreact | fallow | `cmd = function(dispatchers), filetypes = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'}, root_markers = {'.fallowrc.json', '.git'}, init_options = {...}` |
| muttrc, neomuttrc | mutt-language-server | `cmd = { 'mutt-language-server' }, filetypes = {'muttrc', 'neomuttrc'}, root_markers = {'.git'}, settings = {...}` |
| c, css, gitcommit, go, haskell, html, java, javascript, javascriptreact, lua, markdown, php, python, ruby, rust, swift, toml, text, typescript, typescriptreact, zig | codebook-lsp | `cmd = { 'codebook-lsp', 'serve' }, filetypes = {'c', 'css', 'gitcommit', 'go', 'haskell', 'html', 'java', 'javascript', 'javascriptreact', 'lua', 'markdown', 'php', 'python', 'ruby', 'rust', 'swift', 'toml', 'text', 'typescript', 'typescriptreact', 'zig'}, root_markers = {'.git', 'codebook.toml', '.codebook.toml'}` |
| debcontrol, debcopyright, debchangelog, autopkgtest, make, yaml | debputy | `cmd = { 'debputy', 'lsp', 'server' }, filetypes = {'debcontrol', 'debcopyright', 'debchangelog', 'autopkgtest', 'make', 'yaml'}, root_markers = {'debian'}` |
| ziggy_schema | ziggy | `cmd = { 'ziggy', 'lsp', '--schema' }, filetypes = {'ziggy_schema'}, root_markers = {'.git'}` |
| php, twig, yaml, json, xml, javascript, typescript, env | symfony-lsp | `cmd = { 'symfony-lsp' }, filetypes = {'php', 'twig', 'yaml', 'json', 'xml', 'javascript', 'typescript', 'env'}, root_markers = {'composer.json', '.git'}, settings = {...}, init_options = {...}` |
| kotlin | intellij-server | `cmd = { 'intellij-server', '--stdio' }, filetypes = {'kotlin'}, root_markers = {'settings.gradle', 'settings.gradle.kts', 'pom.xml', 'build.gradle', 'build.gradle.kts', 'workspace.json'}` |
| crystal | scry | `cmd = { 'scry' }, filetypes = {'crystal'}, root_markers = {'shard.yml', '.git'}` |
| graphql, typescriptreact, javascriptreact | graphql-lsp | `cmd = { 'graphql-lsp', 'server', '-m', 'stream' }, filetypes = {'graphql', 'typescriptreact', 'javascriptreact'}, root_dir = function(...) end` |
| ruby, rust, javascript, haskell | ttags | `cmd = { 'ttags', 'lsp' }, filetypes = {'ruby', 'rust', 'javascript', 'haskell'}, root_markers = {'.git'}` |
| html, javascriptreact, typescriptreact, astro, svelte, vue, markdown, mdx, javascript, typescript, css, scss, less | wc-language-server | `cmd = { 'wc-language-server', '--stdio' }, filetypes = {'html', 'javascriptreact', 'typescriptreact', 'astro', 'svelte', 'vue', 'markdown', 'mdx', 'javascript', 'typescript', 'css', 'scss', 'less'}, root_markers = {'wc.config.js', 'wc.config.ts', 'wc.config.mjs', 'wc.config.cjs', 'custom-elements.json', 'package.json', '.git'}, init_options = {...}` |
| css, scss, less | cssls | `cmd = function(dispatchers), filetypes = {'css', 'scss', 'less'}, root_markers = {'package.json', '.git'}, settings = {...}, init_options = {...}` |
| nelua | nelua_lsp | `filetypes = {'nelua'}, root_markers = {'Makefile', '.git', '*.nelua'}` |
| aspnetcorerazor, astro, astro-markdown, blade, clojure, django-html, htmldjango, edge, eelixir, elixir, ejs, erb, eruby, gohtml, gohtmltmpl, haml, handlebars, hbs, html, htmlangular, html-eex, heex, jade, leaf, liquid, markdown, mdx, mustache, njk, nunjucks, php, razor, slim, twig, css, less, postcss, sass, scss, stylus, sugarss, javascript, javascriptreact, reason, rescript, typescript, typescriptreact, vue, svelte, templ | tailwindcss | `cmd = function(dispatchers), filetypes = {'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'htmlangular', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss', 'stylus', 'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte', 'templ'}, settings = {...}, root_dir = function(...) end` |
| yar, yara | yls | `cmd = { 'yls', '-vv' }, filetypes = {'yar', 'yara'}, root_markers = {'.git'}` |
| terraform, terraform-vars | terraform-ls | `cmd = { 'terraform-ls', 'serve' }, filetypes = {'terraform', 'terraform-vars'}, root_markers = {'.terraform', '.git'}` |
| hylo | hylo-language-server | `cmd = { 'hylo-language-server', '--stdio' }, filetypes = {'hylo'}, root_markers = {'.git'}, settings = {...}` |
| nextflow | nextflow-language-server | `cmd = { 'nextflow-language-server' }, filetypes = {'nextflow'}, root_markers = {'nextflow.config', '.git'}, settings = {...}` |
| pascal | pasls | `cmd = { 'pasls' }, filetypes = {'pascal'}, root_dir = function(...) end` |
| robot, resource | robotcode | `cmd = { 'robotcode', 'language-server' }, filetypes = {'robot', 'resource'}, root_markers = {'robot.toml', 'pyproject.toml', 'Pipfile', '.git'}` |
| ruby | standardrb | `cmd = { 'standardrb', '--lsp' }, filetypes = {'ruby'}, root_markers = {'Gemfile', '.git'}` |
| go, gomod, gowork, gotmpl | go | `cmd = { 'gopls' }, filetypes = {'go', 'gomod', 'gowork', 'gotmpl'}, settings = {...}, root_dir = function(...) end` |
| bicep, bicep-params | bicep | `filetypes = {'bicep', 'bicep-params'}, root_markers = {'.git'}, init_options = {...}` |
| elixir, eelixir, heex, surface | expert | `cmd = { 'expert', '--stdio' }, filetypes = {'elixir', 'eelixir', 'heex', 'surface'}, root_dir = function(...) end` |
| hare | hare-lsp | `cmd = { 'hare-lsp', '-S' }, filetypes = {'hare'}, root_markers = {'.git'}` |
| jsonnet, libsonnet | jsonnet-language-server | `cmd = { 'jsonnet-language-server' }, filetypes = {'jsonnet', 'libsonnet'}, root_markers = {'jsonnetfile.json', '.git'}` |
| dockerfile | docker-langserver | `cmd = { 'docker-langserver', '--stdio' }, filetypes = {'dockerfile'}, root_markers = {'Dockerfile'}` |
| openscad | openscad-language-server | `cmd = { 'openscad-language-server' }, filetypes = {'openscad'}, root_markers = {'.git'}` |
| p8 | pico8-ls | `cmd = { 'pico8-ls', '--stdio' }, filetypes = {'p8'}, settings = {...}, root_dir = function(...) end` |
| config, automake, make | autotools-language-server | `cmd = { 'autotools-language-server' }, filetypes = {'config', 'automake', 'make'}, root_dir = function(...) end` |
| elixir, eelixir, heex, surface | nextls | `cmd = { 'nextls', '--stdio' }, filetypes = {'elixir', 'eelixir', 'heex', 'surface'}, root_markers = {'mix.exs', '.git'}` |
| liquid | shopify | `cmd = { 'shopify', 'theme', 'language-server' }, filetypes = {'liquid'}, root_markers = {'.shopifyignore', '.theme-check.yml', '.theme-check.yaml', 'shopify.theme.toml'}, settings = {...}` |
| cs, vb | OmniSharp | `cmd = { vim.fn.executable('OmniSharp') == 1 and 'OmniSharp' or 'omnisharp', '-z', '--hostPID', tostring(vim.fn.getpid()), 'DotNet:enablePackageRestore=false', '--encoding', 'utf-8', '--languageserver' }, filetypes = {'cs', 'vb'}, settings = {...}, init_options = {...}, root_dir = function(...) end` |
| markdown, org | ds_pinyin_lsp | `cmd = { bin_name }, filetypes = {'markdown', 'org'}, root_markers = {'.git'}, init_options = {...}` |
| twig | twiggy-language-server | `cmd = { 'twiggy-language-server', '--stdio' }, filetypes = {'twig'}, root_markers = {'composer.json', '.git'}` |
| sd, profile, yql | java | `cmd = { 'java', '-jar', 'vespa-language-server.jar' }, filetypes = {'sd', 'profile', 'yql'}, root_markers = {'.git'}` |
| hcl | terragrunt-ls | `cmd = { 'terragrunt-ls' }, filetypes = {'hcl'}, root_markers = {'terragrunt.hcl', '.git'}` |
| perl | pls | `cmd = { 'pls' }, filetypes = {'perl'}, root_markers = {'.git'}, settings = {...}` |
| bash, sh, zsh | shuck | `cmd = { 'shuck', 'server' }, filetypes = {'bash', 'sh', 'zsh'}, root_markers = {'.shuck.toml', '.git'}` |
| custom_elements_ls | custom-elements-languageserver | `cmd = { 'custom-elements-languageserver', '--stdio' }, root_markers = {'tsconfig.json', 'package.json', 'jsconfig.json', '.git'}, init_options = {...}` |
| polar | oso-cloud | `cmd = { 'oso-cloud', 'lsp' }, filetypes = {'polar'}` |
| nginx | nginx-language-server | `cmd = { 'nginx-language-server' }, filetypes = {'nginx'}, root_markers = {'nginx.conf', '.git'}` |
| erg | erg | `cmd = { 'erg', '--language-server' }, filetypes = {'erg'}, root_markers = {'package.er', '.git'}` |
| copilot | copilot-language-server | `cmd = { 'copilot-language-server', '--stdio' }, root_markers = {'.git'}, settings = {...}, init_options = {...}` |
| vhd, vhdl | vhdl_ls | `cmd = { 'vhdl_ls' }, filetypes = {'vhd', 'vhdl'}, root_markers = {'vhdl_ls.toml'}` |
| javascript, javascriptreact, typescript, typescriptreact | vtsls | `cmd = { 'vtsls', '--stdio' }, filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}, root_markers = {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock'}, init_options = {...}, root_dir = function(...) end` |
| json, jsonc | nxls | `cmd = { 'nxls', '--stdio' }, filetypes = {'json', 'jsonc'}, root_markers = {'nx.json', '.git'}` |
| wgsl | glasgow | `cmd = { 'glasgow' }, filetypes = {'wgsl'}, root_markers = {'.git'}, settings = {...}` |
| beancount, bean | beancount-language-server | `cmd = { 'beancount-language-server', '--stdio' }, filetypes = {'beancount', 'bean'}, root_markers = {'.git'}, init_options = {...}` |
| nim | nimlsp | `cmd = { 'nimlsp' }, filetypes = {'nim'}, root_dir = function(...) end` |
| lsp_ai | lsp-ai | `cmd = { 'lsp-ai' }, filetypes = {}, init_options = {...}` |
| mint | mint | `cmd = { 'mint', 'ls' }, filetypes = {'mint'}, root_markers = {'mint.json', '.git'}` |
| rust | rust-glancer | `cmd = { 'rust-glancer', 'lsp' }, filetypes = {'rust'}, root_dir = function(...) end` |
| python | zuban | `cmd = { 'zuban', 'server' }, filetypes = {'python'}, root_markers = {'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git'}` |
| spade | spade-language-server | `cmd = { 'spade-language-server' }, filetypes = {'spade'}, root_markers = {'swim.toml'}` |
| yaml.docker-compose | docker-compose-langserver | `cmd = { 'docker-compose-langserver', '--stdio' }, filetypes = {'yaml.docker-compose'}, root_markers = {'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml'}` |
| vala, genie | vala-language-server | `cmd = { 'vala-language-server' }, filetypes = {'vala', 'genie'}, root_dir = function(...) end` |
| ballerina | bal | `cmd = { 'bal', 'start-language-server' }, filetypes = {'ballerina'}, root_markers = {'Ballerina.toml'}` |
| css | csskit | `cmd = { 'csskit', 'lsp' }, filetypes = {'css'}, root_markers = {'package.json', '.git'}` |
| python | pyre | `cmd = { 'pyre', 'persistent' }, filetypes = {'python'}, root_markers = {'.pyre_configuration'}` |
| pdll | mlir-pdll-lsp-server | `cmd = { 'mlir-pdll-lsp-server' }, filetypes = {'pdll'}, root_markers = {'pdll_compile_commands.yml', '.git'}` |
| php | php-lsp | `cmd = { 'php-lsp' }, filetypes = {'php'}, root_markers = {'composer.json', '.git'}` |
| r, rmd, quarto | R | `cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' }, filetypes = {'r', 'rmd', 'quarto'}, root_dir = function(...) end` |
| ruby | solargraph | `cmd = { 'solargraph', 'stdio' }, filetypes = {'ruby'}, root_markers = {'Gemfile', '.git'}, settings = {...}, init_options = {...}` |
| javascript, javascriptreact, typescript, typescriptreact | deno | `cmd = { 'deno', 'lsp' }, filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}, root_markers = {'deno.lock', 'deno.json', 'deno.jsonc'}, settings = {...}, root_dir = function(...) end` |
| matlab | matlab-language-server | `cmd = { 'matlab-language-server', '--stdio' }, filetypes = {'matlab'}, settings = {...}, root_dir = function(...) end` |
| perl | perl | `cmd = { 'perl', '-MPerl::LanguageServer', '-e', 'Perl::LanguageServer::run', '--', '--port 13603', '--nostdio 0' }, filetypes = {'perl'}, root_markers = {'.git'}, settings = {...}` |
| wgsl | wgsl-analyzer | `cmd = { 'wgsl-analyzer' }, filetypes = {'wgsl'}, root_markers = {'.git'}, settings = {...}` |
| v, vsh, vv | v-analyzer | `cmd = { 'v-analyzer' }, filetypes = {'v', 'vsh', 'vv'}, root_markers = {'v.mod', '.git'}` |
| clojure, edn | clojure-lsp | `cmd = { 'clojure-lsp' }, filetypes = {'clojure', 'edn'}, root_markers = {'project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn', '.git', 'bb.edn'}` |
| asciidoc, c, cpp, cs, gitcommit, go, html, java, javascript, lua, markdown, nix, python, ruby, rust, swift, tex, toml, typescript, typescriptreact, haskell, cmake, typst, php, dart, clojure, sh | harper-ls | `cmd = { 'harper-ls', '--stdio' }, filetypes = {'asciidoc', 'c', 'cpp', 'cs', 'gitcommit', 'go', 'html', 'java', 'javascript', 'lua', 'markdown', 'nix', 'python', 'ruby', 'rust', 'swift', 'tex', 'toml', 'typescript', 'typescriptreact', 'haskell', 'cmake', 'typst', 'php', 'dart', 'clojure', 'sh'}, root_markers = {'.harper-dictionary.txt', '.git'}` |
| python | anakinls | `cmd = { 'anakinls' }, filetypes = {'python'}, root_markers = {'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git'}, settings = {...}` |
| cql, cqlang | cqlls | `cmd = { 'cqlls' }, filetypes = {'cql', 'cqlang'}, root_markers = {'.cqlls', '.git'}, settings = {...}` |
| hlsl, shaderslang | slangd | `cmd = { 'slangd' }, filetypes = {'hlsl', 'shaderslang'}, root_markers = {'slangdconfig.json', '.clang-format', '.git'}` |
| solidity | solidity-ls | `cmd = { 'solidity-ls', '--stdio' }, filetypes = {'solidity'}, root_markers = {'.git', 'package.json'}, settings = {...}` |
| ruby | rubocop | `cmd = { 'rubocop', '--lsp' }, filetypes = {'ruby'}, root_markers = {'Gemfile', '.git'}` |
| ttcn | ntt | `cmd = { 'ntt', 'langserver' }, filetypes = {'ttcn'}, root_markers = {'.git'}` |
| verilog, systemverilog | svlangserver | `cmd = { 'svlangserver' }, filetypes = {'verilog', 'systemverilog'}, root_markers = {'.svlangserver', '.git'}, settings = {...}` |
| awk | awk-language-server | `cmd = { 'awk-language-server' }, filetypes = {'awk'}` |
| circom | circom-lsp | `cmd = { 'circom-lsp' }, filetypes = {'circom'}, root_markers = {'.git'}` |
| ps1 | powershell_es | `cmd = function(dispatchers), filetypes = {'ps1'}, root_markers = {'PSScriptAnalyzerSettings.psd1', '.git'}, init_options = {...}` |
| nu | nu | `cmd = { 'nu', '--lsp' }, filetypes = {'nu'}, root_dir = function(...) end` |
| astro, css, graphql, html, javascript, javascriptreact, json, jsonc, svelte, typescript, typescriptreact, vue | biome | `cmd = function(dispatchers), filetypes = {'astro', 'css', 'graphql', 'html', 'javascript', 'javascriptreact', 'json', 'jsonc', 'svelte', 'typescript', 'typescriptreact', 'vue'}, root_markers = {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock', 'deno.lock'}, root_dir = function(...) end` |
| meson | muon | `cmd = { 'muon', 'analyze', 'lsp' }, filetypes = {'meson'}, root_dir = function(...) end` |
| elixir, eelixir, heex, surface | elixir-ls | `cmd = { 'elixir-ls' }, filetypes = {'elixir', 'eelixir', 'heex', 'surface'}, root_dir = function(...) end` |
| htmldjango, html, python | djls | `cmd = { 'djls', 'serve' }, filetypes = {'htmldjango', 'html', 'python'}, root_markers = {'manage.py', 'pyproject.toml', '.git'}` |
| haskell | hie-wrapper | `cmd = { 'hie-wrapper', '--lsp' }, filetypes = {'haskell'}, root_markers = {'stack.yaml', 'package.yaml', '.git'}` |
| help | vimdoc-language-server | `cmd = { 'vimdoc-language-server' }, filetypes = {'help'}, root_markers = {'doc', '.git'}` |
| sixtyfps | sixtyfps-lsp | `cmd = { 'sixtyfps-lsp' }, filetypes = {'sixtyfps'}` |
| sql, mysql | sqls | `cmd = { 'sqls' }, filetypes = {'sql', 'mysql'}, root_markers = {'config.yml'}, settings = {...}` |
| lua | stylua | `cmd = { 'stylua', '--lsp' }, filetypes = {'lua'}, root_markers = {'.stylua.toml', 'stylua.toml', '.editorconfig'}` |
| ato | ato | `cmd = { 'ato', 'lsp', 'start' }, filetypes = {'ato'}, root_markers = {'ato.yaml', '.ato', '.git'}` |
| php, hack | hhvm | `cmd = function(dispatchers), filetypes = {'php', 'hack'}, root_markers = {'.hhconfig'}` |
| zig, zir | zls | `cmd = { 'zls' }, filetypes = {'zig', 'zir'}, root_markers = {'zls.json', 'build.zig', '.git'}` |
| systemverilog, verilog | veridian | `cmd = { 'veridian' }, filetypes = {'systemverilog', 'verilog'}, root_markers = {'.git'}` |
| motoko | motoko-lsp | `cmd = { 'motoko-lsp', '--stdio' }, filetypes = {'motoko'}, root_markers = {'dfx.json', '.git'}, init_options = {...}` |
| python | jedi-language-server | `cmd = { 'jedi-language-server' }, filetypes = {'python'}, root_markers = {'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git'}` |
| scss, sass | some-sass-language-server | `cmd = { 'some-sass-language-server', '--stdio' }, filetypes = {'scss', 'sass'}, root_markers = {'.git', '.package.json'}, settings = {...}` |
| opentofu, opentofu-vars, terraform | tofu-ls | `cmd = { 'tofu-ls', 'serve' }, filetypes = {'opentofu', 'opentofu-vars', 'terraform'}, root_markers = {'.terraform', '.git'}` |
| yaml.gitlab | gitlab-ci-ls | `cmd = { 'gitlab-ci-ls' }, filetypes = {'yaml.gitlab'}, init_options = {...}, root_dir = function(...) end` |
| astro, css, html, less, scss, vue | stylelint-language-server | `cmd = { 'stylelint-language-server', '--stdio' }, filetypes = {'astro', 'css', 'html', 'less', 'scss', 'vue'}, root_markers = {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock'}, settings = {...}, root_dir = function(...) end` |
| diagnosticls | diagnostic-languageserver | `cmd = { 'diagnostic-languageserver', '--stdio' }, filetypes = {}, root_markers = {'.git'}` |
| apex, apexcode | apex_ls | `cmd = function(dispatchers), filetypes = {'apex', 'apexcode'}, root_markers = {'sfdx-project.json'}` |
| python | pylyzer | `cmd = { 'pylyzer', '--server' }, filetypes = {'python'}, root_markers = {'setup.py', 'tox.ini', 'requirements.txt', 'Pipfile', 'pyproject.toml', '.git'}, settings = {...}` |
| html.handlebars, handlebars, typescript, typescript.glimmer, javascript, javascript.glimmer | glint | `cmd = function(dispatchers), filetypes = {'html.handlebars', 'handlebars', 'typescript', 'typescript.glimmer', 'javascript', 'javascript.glimmer'}, root_markers = {'.glintrc.yml', '.glintrc', '.glintrc.json', '.glintrc.js', 'glint.config.js', 'package.json'}, init_options = {...}` |
| superhtml, html | superhtml | `cmd = { 'superhtml', 'lsp' }, filetypes = {'superhtml', 'html'}, root_markers = {'.git'}` |
| handlebars, typescript, javascript, typescript.glimmer, javascript.glimmer | ember-language-server | `cmd = { 'ember-language-server', '--stdio' }, filetypes = {'handlebars', 'typescript', 'javascript', 'typescript.glimmer', 'javascript.glimmer'}, root_markers = {'ember-cli-build.js', '.git'}` |
| vue | vue-language-server | `cmd = { 'vue-language-server', '--stdio' }, filetypes = {'vue'}, root_markers = {'package.json'}` |
| solidity | nomicfoundation-solidity-language-server | `cmd = { 'nomicfoundation-solidity-language-server', '--stdio' }, filetypes = {'solidity'}, root_markers = {'hardhat.config.js', 'hardhat.config.ts', 'foundry.toml', 'remappings.txt', 'truffle.js', 'truffle-config.js', 'ape-config.yaml', '.git', 'package.json'}` |
| basics_ls | basics-language-server | `cmd = { 'basics-language-server' }, settings = {...}` |
| coq | vsrocqtop | `cmd = { 'vsrocqtop' }, filetypes = {'coq'}, root_markers = {'_RocqProject', '_CoqProject', '.git'}` |
| groovy | gradle_ls | `cmd = { bin_name }, filetypes = {'groovy'}, root_markers = {'settings.gradle', 'build.gradle'}, settings = {...}, init_options = {...}` |
| rust | bacon-ls | `cmd = { 'bacon-ls' }, filetypes = {'rust'}, root_markers = {'.bacon-locations', 'Cargo.toml'}, init_options = {...}` |
| php | phpactor | `cmd = { 'phpactor', 'language-server' }, filetypes = {'php'}, root_markers = {'.git', 'composer.json', '.phpactor.json', '.phpactor.yml'}` |
| pony | pony-lsp | `cmd = { 'pony-lsp' }, filetypes = {'pony'}, root_markers = {'corral.json', '.git'}, settings = {...}` |
| smt2, tptp, p, cnf, icnf, zf | dolmenls | `cmd = { 'dolmenls' }, filetypes = {'smt2', 'tptp', 'p', 'cnf', 'icnf', 'zf'}, root_markers = {'.git'}` |
| liquid | theme-check-language-server | `cmd = { 'theme-check-language-server', '--stdio' }, filetypes = {'liquid'}, root_markers = {'.theme-check.yml'}, settings = {...}` |
| prisma | prisma-language-server | `cmd = { 'prisma-language-server', '--stdio' }, filetypes = {'prisma'}, root_markers = {'.git', 'package.json'}, settings = {...}` |
| rego | regal | `cmd = { 'regal', 'language-server' }, filetypes = {'rego'}, root_dir = function(...) end` |
| rst | esbonio | `cmd = { 'esbonio', 'server' }, filetypes = {'rst'}, root_markers = {'conf.py', '.git'}` |
| toml | tombi | `cmd = { 'tombi', 'lsp' }, filetypes = {'toml'}, root_markers = {'tombi.toml', 'pyproject.toml', '.git'}` |
| haskell, lhaskell | haskell-language-server-wrapper | `cmd = { 'haskell-language-server-wrapper', '--lsp' }, filetypes = {'haskell', 'lhaskell'}, settings = {...}, root_dir = function(...) end` |
| typst | typst-lsp | `cmd = { 'typst-lsp' }, filetypes = {'typst'}, root_markers = {'.git'}` |
| ctags_lsp | ctags-lsp | `cmd = { 'ctags-lsp' }, root_markers = {'tags', '.tags', '.git'}` |
| stan | stan-language-server | `cmd = { 'stan-language-server', '--stdio' }, filetypes = {'stan'}, root_markers = {'.git'}, settings = {...}` |
| jq | jq-lsp | `cmd = { 'jq-lsp' }, filetypes = {'jq'}, root_markers = {'.git'}` |
| raku | raku_navigator | `cmd = {}, filetypes = {'raku'}, root_markers = {'.git'}` |
| java | java-language-server | `cmd = { 'java-language-server' }, filetypes = {'java'}, root_markers = {'build.gradle', 'build.gradle.kts', 'pom.xml', '.git'}, settings = {...}` |
| prolog | swipl | `cmd = { 'swipl', '-g', 'use_module(library(lsp_server)).', '-g', 'lsp_server:main', '-t', 'halt', '--', 'stdio' }, filetypes = {'prolog'}, root_markers = {'pack.pl'}` |
| bash, c, cpp, cs, css, elixir, go, haskell, html, java, javascript, javascriptreact, json, kotlin, lua, nix, php, python, ruby, rust, scala, sh, solidity, swift, typescript, typescriptreact, yaml | ast-grep | `cmd = { 'ast-grep', 'lsp' }, filetypes = {'bash', 'c', 'cpp', 'cs', 'css', 'elixir', 'go', 'haskell', 'html', 'java', 'javascript', 'javascriptreact', 'json', 'kotlin', 'lua', 'nix', 'php', 'python', 'ruby', 'rust', 'scala', 'sh', 'solidity', 'swift', 'typescript', 'typescriptreact', 'yaml'}, root_markers = {'sgconfig.yaml', 'sgconfig.yml'}` |
| kotlin | kotlin-language-server | `cmd = { 'kotlin-language-server' }, filetypes = {'kotlin'}, init_options = {...}` |
| c3, c3i | c3lsp | `cmd = { 'c3lsp' }, filetypes = {'c3', 'c3i'}, root_markers = {'project.json', 'manifest.json', '.git'}` |
| markdown, quarto, rmd | panache | `cmd = { 'panache', 'lsp' }, filetypes = {'markdown', 'quarto', 'rmd'}, root_markers = {'.panache.toml', 'panache.toml', '_quarto.yml', '_bookdown.yml', '.git'}` |
| ocaml, menhir, ocamlinterface, ocamllex, reason, dune | ocamllsp | `cmd = { 'ocamllsp' }, filetypes = {'ocaml', 'menhir', 'ocamlinterface', 'ocamllex', 'reason', 'dune'}` |
| v, vlang | v | `cmd = { 'v', 'ls' }, filetypes = {'v', 'vlang'}, root_markers = {'v.mod', '.git'}` |
| lean3 | lean-language-server | `cmd = { 'lean-language-server', '--stdio', '--', '-M', '4096', '-T', '100000' }, filetypes = {'lean3'}, root_dir = function(...) end` |
| python | ty | `cmd = { 'ty', 'server' }, filetypes = {'python'}, root_markers = {'ty.toml', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git'}` |
| python | pytest-language-server | `cmd = { 'pytest-language-server' }, filetypes = {'python'}, root_markers = {'pytest.ini', 'pyproject.toml', 'setup.py', 'setup.cfg', '.git'}` |
| meson | mesonlsp | `cmd = { 'mesonlsp', '--lsp' }, filetypes = {'meson'}, root_dir = function(...) end` |
| cs | csharp_ls | `cmd = function(dispatchers), filetypes = {'cs'}, init_options = {...}, root_dir = function(...) end` |
| bazelrc | bazelrc-lsp | `cmd = { 'bazelrc-lsp', 'lsp' }, filetypes = {'bazelrc'}, root_markers = {'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel'}` |
| dart | dcm | `cmd = { 'dcm', 'start-server', '--client=neovim' }, filetypes = {'dart'}, root_markers = {'pubspec.yaml'}` |
| meson | Swift-MesonLSP | `cmd = { 'Swift-MesonLSP', '--lsp' }, filetypes = {'meson'}, root_markers = {'meson.build', 'meson_options.txt', 'meson.options', '.git'}` |
| asm68k | m68k-lsp-server | `cmd = { 'm68k-lsp-server', '--stdio' }, filetypes = {'asm68k'}, root_markers = {'Makefile', '.git'}` |
| lua | selene-3p-language-server | `cmd = { 'selene-3p-language-server' }, filetypes = {'lua'}, root_markers = {'selene.toml'}` |
| alloy | alloy | `cmd = { 'alloy', 'lsp' }, filetypes = {'alloy'}, root_markers = {'.git'}` |
| nix | nixd | `cmd = { 'nixd' }, filetypes = {'nix'}, root_markers = {'flake.nix', '.git'}` |
| cmake | neocmakelsp | `cmd = { 'neocmakelsp', 'stdio' }, filetypes = {'cmake'}, root_markers = {'.neocmake.toml', '.git', 'build', 'cmake'}` |
| nim | nimlangserver | `cmd = { 'nimlangserver' }, filetypes = {'nim'}, root_dir = function(...) end` |
| racket, scheme | racket | `cmd = { 'racket', '--lib', 'racket-langserver' }, filetypes = {'racket', 'scheme'}, root_markers = {'.git'}` |
| just | just-lsp | `cmd = { 'just-lsp' }, filetypes = {'just'}, root_markers = {'.git'}` |
| yaml | zizmor | `cmd = { 'zizmor', '--lsp' }, filetypes = {'yaml'}, init_options = {...}, root_dir = function(...) end` |
| hcl.nomad, nomad | nomad_lsp | `cmd = { bin_name }, filetypes = {'hcl.nomad', 'nomad'}, root_dir = function(...) end` |
| fsharp | fsautocomplete | `cmd = { 'fsautocomplete', '--adaptive-lsp-server-enabled' }, filetypes = {'fsharp'}, settings = {...}, init_options = {...}, root_dir = function(...) end` |
| rescript | rescript-language-server | `cmd = { 'rescript-language-server', '--stdio' }, filetypes = {'rescript'}, root_markers = {'bsconfig.json', 'rescript.json', '.git'}, settings = {...}, init_options = {...}` |
| dockerfile, yaml.docker-compose | docker-language-server | `cmd = { 'docker-language-server', 'start', '--stdio' }, filetypes = {'dockerfile', 'yaml.docker-compose'}, root_markers = {'Dockerfile', 'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml', 'docker-bake.json', 'docker-bake.hcl', 'docker-bake.override.json', 'docker-bake.override.hcl'}` |
| fish | fish-lsp | `cmd = { 'fish-lsp', 'start' }, filetypes = {'fish'}, root_markers = {'config.fish', '.git'}` |
| dts, dtsi, overlay | dts-lsp | `cmd = { 'dts-lsp' }, filetypes = {'dts', 'dtsi', 'overlay'}, root_markers = {'.git'}, settings = {...}` |
| hyprlang | hyprls | `cmd = { 'hyprls', '--stdio' }, filetypes = {'hyprlang'}, root_markers = {'.git'}` |
| opencl | opencl-language-server | `cmd = { 'opencl-language-server' }, filetypes = {'opencl'}, root_markers = {'.git'}` |
| yaml | azure-pipelines-language-server | `cmd = { 'azure-pipelines-language-server', '--stdio' }, filetypes = {'yaml'}, root_markers = {'azure-pipelines.yml'}, settings = {...}` |
| bzl | starpls | `cmd = { 'starpls' }, filetypes = {'bzl'}, root_markers = {'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel'}` |
| visualforce | visualforce_ls | `filetypes = {'visualforce'}, root_markers = {'sfdx-project.json'}, init_options = {...}` |
| teal | teal-language-server | `cmd = { 'teal-language-server' }, filetypes = {'teal'}, root_markers = {'tlconfig.lua'}` |
| erlang | elp | `cmd = { 'elp', 'server' }, filetypes = {'erlang'}, root_markers = {'rebar.config', 'erlang.mk', '.git'}` |
| php | devsense-php-ls | `cmd = { 'devsense-php-ls', '--stdio' }, filetypes = {'php'}, init_options = {...}, root_dir = function(...) end` |
| markdown | prosemd-lsp | `cmd = { 'prosemd-lsp', '--stdio' }, filetypes = {'markdown'}, root_markers = {'.git'}` |
| php, blade | laravel-ls | `cmd = { 'laravel-ls' }, filetypes = {'php', 'blade'}, root_markers = {'artisan'}` |
| futhark, fut | futhark | `cmd = { 'futhark', 'lsp' }, filetypes = {'futhark', 'fut'}, root_markers = {'.git'}` |
| vhdl | ghdl-ls | `cmd = { 'ghdl-ls' }, filetypes = {'vhdl'}, root_markers = {'hdl-prj.json', '.git'}` |
| janet | janet-lsp | `cmd = { 'janet-lsp', '--stdio' }, filetypes = {'janet'}, root_markers = {'project.janet', '.git'}` |
| asciidoc, bib, context, gitcommit, html, markdown, org, pandoc, plaintex, quarto, mail, mdx, rmd, rnoweb, rst, tex, text, typst, xhtml | ltex-ls-plus | `cmd = { 'ltex-ls-plus' }, filetypes = {'asciidoc', 'bib', 'context', 'gitcommit', 'html', 'markdown', 'org', 'pandoc', 'plaintex', 'quarto', 'mail', 'mdx', 'rmd', 'rnoweb', 'rst', 'tex', 'text', 'typst', 'xhtml'}, root_markers = {'.git'}, settings = {...}` |
| sml | millet | `cmd = { 'millet' }, filetypes = {'sml'}, root_markers = {'millet.toml'}` |
| java | jls | `cmd = { 'jls' }, filetypes = {'java'}, root_markers = {'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'settings.gradle.kts', 'WORKSPACE', 'WORKSPACE.bazel', '.java-version'}, settings = {...}` |
| smarty | smarty-language-server | `cmd = { 'smarty-language-server', '--stdio' }, filetypes = {'smarty'}, settings = {...}, init_options = {...}, root_dir = function(...) end` |
| luau | luau-lsp | `cmd = { 'luau-lsp', 'lsp' }, filetypes = {'luau'}, root_markers = {'.git'}` |
| erb, haml, hbs, html, css, postcss, javascript, javascriptreact, markdown, ejs, php, svelte, typescript, typescriptreact, vue-html, vue, sass, scss, less, stylus, astro, rescript, rust | unocss-language-server | `cmd = { 'unocss-language-server', '--stdio' }, filetypes = {'erb', 'haml', 'hbs', 'html', 'css', 'postcss', 'javascript', 'javascriptreact', 'markdown', 'ejs', 'php', 'svelte', 'typescript', 'typescriptreact', 'vue-html', 'vue', 'sass', 'scss', 'less', 'stylus', 'astro', 'rescript', 'rust'}, root_markers = {'unocss.config.js', 'unocss.config.ts', 'uno.config.js', 'uno.config.ts'}` |
| autohotkey | autohotkey_lsp | `cmd = { 'autohotkey_lsp', '--stdio' }, filetypes = {'autohotkey'}, root_markers = {'package.json'}, init_options = {...}` |
| star, bzl, BUILD.bazel | starlark | `cmd = { 'starlark', '--lsp' }, filetypes = {'star', 'bzl', 'BUILD.bazel'}, root_markers = {'.git'}` |
| astro, css, eruby, html, htmlangular, htmldjango, javascriptreact, less, sass, scss, svelte, typescriptreact, vue | emmet-language-server | `cmd = { 'emmet-language-server', '--stdio' }, filetypes = {'astro', 'css', 'eruby', 'html', 'htmlangular', 'htmldjango', 'javascriptreact', 'less', 'sass', 'scss', 'svelte', 'typescriptreact', 'vue'}, root_markers = {'.git'}` |
| markdown | remark-language-server | `cmd = { 'remark-language-server', '--stdio' }, filetypes = {'markdown'}, root_markers = {'.remarkrc', '.remarkrc.json', '.remarkrc.js', '.remarkrc.cjs', '.remarkrc.mjs', '.remarkrc.yml', '.remarkrc.yaml', '.remarkignore'}` |
| pug | pug-lsp | `cmd = { 'pug-lsp' }, filetypes = {'pug'}, root_markers = {'package.json'}` |
| ruby, eruby | steep | `cmd = { 'steep', 'langserver' }, filetypes = {'ruby', 'eruby'}, root_markers = {'Steepfile', '.git'}` |
| contextive | Contextive.LanguageServer | `cmd = { 'Contextive.LanguageServer' }, root_markers = {'.contextive', '.git'}` |
| metamath-zero | mm0-rs | `cmd = { 'mm0-rs', 'server' }, filetypes = {'metamath-zero'}, root_markers = {'.git'}` |
| llw | lelwel-ls | `cmd = { 'lelwel-ls' }, filetypes = {'llw'}, root_markers = {'.git'}` |
| python | pyright-langserver | `cmd = { 'pyright-langserver', '--stdio' }, filetypes = {'python'}, root_markers = {'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git'}, settings = {...}` |
| ruby, eruby | typeprof | `cmd = { 'typeprof', '--lsp', '--stdio' }, filetypes = {'ruby', 'eruby'}, root_markers = {'Gemfile', '.git'}` |
| vectorcode_server | vectorcode-server | `cmd = { 'vectorcode-server' }, settings = {...}` |
| uiua | uiua | `cmd = { 'uiua', 'lsp' }, filetypes = {'uiua'}, root_markers = {'main.ua', '.fmt.ua', '.git'}` |
| pkl, pcf | pkl-lsp | `cmd = { 'pkl-lsp' }, filetypes = {'pkl', 'pcf'}, root_markers = {'PklProject', '.git'}` |
| rust | rust-analyzer | `cmd = { 'rust-analyzer' }, filetypes = {'rust'}, settings = {...}, root_dir = function(...) end` |
| cmake | cmake-language-server | `cmd = { 'cmake-language-server' }, filetypes = {'cmake'}, root_markers = {'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake'}, init_options = {...}` |
| cds | cds-lsp | `cmd = { 'cds-lsp', '--stdio' }, filetypes = {'cds'}, root_markers = {'package.json', 'db', 'srv'}, settings = {...}` |
| tex, plaintex, context | digestif | `cmd = { 'digestif' }, filetypes = {'tex', 'plaintex', 'context'}, root_markers = {'.git'}` |
| typst | tinymist | `cmd = { 'tinymist' }, filetypes = {'typst'}, root_markers = {'.git'}` |
| jinja | jinja-lsp | `cmd = { 'jinja-lsp' }, filetypes = {'jinja'}, root_markers = {'.git'}` |
| idris2 | idris2-lsp | `cmd = { 'idris2-lsp' }, filetypes = {'idris2'}, root_dir = function(...) end` |
| yaml, yaml.docker-compose, yaml.gitlab, yaml.helm-values | yamlls | `cmd = function(dispatchers), filetypes = {'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values'}, root_markers = {'.git'}, settings = {...}` |
| reason | reason-language-server | `cmd = { 'reason-language-server' }, filetypes = {'reason'}, root_markers = {'bsconfig.json', '.git'}` |
| nix | nil | `cmd = { 'nil' }, filetypes = {'nix'}, root_markers = {'flake.nix', '.git'}` |
| d | DaedalusLanguageServer | `cmd = { 'DaedalusLanguageServer' }, filetypes = {'d'}, root_markers = {'Gothic.src', 'Camera.src', 'Menu.src', 'Music.src', 'ParticleFX.src', 'SFX.src', 'VisualFX.src'}, settings = {...}` |
| rune | rune-languageserver | `cmd = { 'rune-languageserver' }, filetypes = {'rune'}, root_markers = {'.git'}` |
| markdown | zk | `cmd = { 'zk', 'lsp' }, filetypes = {'markdown'}, root_markers = {'.zk'}` |
| pli | pli_language_server | `cmd = { 'pli_language_server' }, filetypes = {'pli'}, root_markers = {'.pliplugin'}` |
| pory | poryscript-pls | `cmd = { 'poryscript-pls' }, filetypes = {'pory'}, root_markers = {'.git'}` |
| cucumber | cucumber-language-server | `cmd = { 'cucumber-language-server', '--stdio' }, filetypes = {'cucumber'}, root_markers = {'.git'}` |
| solidity | vscode-solidity-server | `cmd = { 'vscode-solidity-server', '--stdio' }, filetypes = {'solidity'}, root_markers = {'hardhat.config.js', 'hardhat.config.ts', 'foundry.toml', 'remappings.txt', 'truffle.js', 'truffle-config.js', 'ape-config.yaml', '.git', 'package.json'}` |
| c, cpp, objc, objcpp, cuda | ccls | `cmd = { 'ccls' }, filetypes = {'c', 'cpp', 'objc', 'objcpp', 'cuda'}, root_markers = {'compile_commands.json', '.ccls', '.git'}` |
| mma | WolframKernel | `cmd = { 'WolframKernel', '-noinit', '-noprompt', '-nopaclet', '-noicon', '-nostartuppaclets', '-run', 'Needs["LSPServer`"];LSPServer`StartServer[]' }, filetypes = {'mma'}, root_markers = {'.git'}, init_options = {...}` |
| fennel | fennel-language-server | `cmd = { 'fennel-language-server' }, filetypes = {'fennel'}, root_markers = {'.git'}, settings = {...}` |
| solidity | solc | `cmd = { 'solc', '--lsp' }, filetypes = {'solidity'}, root_dir = function(...) end` |
| marko | marko-language-server | `cmd = { 'marko-language-server', '--stdio' }, filetypes = {'marko'}, root_markers = {'.git'}` |
| aspnetcorerazor, astro, astro-markdown, blade, clojure, django-html, htmldjango, edge, eelixir, elixir, ejs, erb, eruby, gohtml, gohtmltmpl, haml, handlebars, hbs, html, htmlangular, html-eex, heex, jade, leaf, liquid, markdown, mdx, mustache, njk, nunjucks, php, razor, slim, twig, javascript, javascriptreact, reason, rescript, typescript, typescriptreact, vue, svelte, templ | htmx-lsp | `cmd = { 'htmx-lsp' }, filetypes = {'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'htmlangular', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte', 'templ'}, root_markers = {'.git'}` |
| mcfunction | spyglassmc-language-server | `cmd = { 'spyglassmc-language-server', '--stdio' }, filetypes = {'mcfunction'}, root_markers = {'pack.mcmeta'}` |
| python | pyrefly | `cmd = { 'pyrefly', 'lsp' }, filetypes = {'python'}, root_markers = {'pyrefly.toml', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git'}` |
| query | ts_query_ls | `cmd = { 'ts_query_ls' }, filetypes = {'query'}, root_markers = {'.tsqueryrc.json', '.git'}, init_options = {...}` |
| ncl, nickel | nls | `cmd = { 'nls' }, filetypes = {'ncl', 'nickel'}, root_markers = {'.git'}` |
| php | psalm | `cmd = { 'psalm', '--language-server' }, filetypes = {'php'}, root_markers = {'psalm.xml', 'psalm.xml.dist'}` |
| css, scss, less | css-variables-language-server | `cmd = { 'css-variables-language-server', '--stdio' }, filetypes = {'css', 'scss', 'less'}, root_markers = {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock'}, settings = {...}, root_dir = function(...) end` |
| svelte | svelte | `cmd = function(dispatchers), filetypes = {'svelte'}, root_markers = {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock', 'deno.lock'}, settings = {...}, root_dir = function(...) end` |
| thrift | thriftls | `cmd = { 'thriftls' }, filetypes = {'thrift'}, root_markers = {'.thrift'}` |
| bib, gitcommit, markdown, org, plaintex, rst, rnoweb, tex, pandoc, quarto, rmd, context, html, xhtml, mail, text | ltex-ls | `cmd = { 'ltex-ls' }, root_markers = {'.git'}, settings = {...}` |
| mojo | mojo-lsp-server | `cmd = { 'mojo-lsp-server' }, filetypes = {'mojo'}, root_markers = {'.git'}` |
| ziggy | ziggy | `cmd = { 'ziggy', 'lsp' }, filetypes = {'ziggy'}, root_markers = {'.git'}` |
| gdscript | gdscript | `cmd = cmd, filetypes = {'gdscript'}, root_markers = {'project.godot', '.git'}` |
| javascript, javascriptreact, typescript, typescriptreact, json, jsonc, markdown, python, toml, rust, roslyn, graphql | dprint | `cmd = { 'dprint', 'lsp' }, filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc', 'markdown', 'python', 'toml', 'rust', 'roslyn', 'graphql'}, root_markers = {'dprint.json', '.dprint.json', 'dprint.jsonc', '.dprint.jsonc'}, settings = {...}` |
| javascript, javascriptreact, typescript, typescriptreact | tsc | `cmd = function(dispatchers), filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}, root_markers = {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock'}, settings = {...}, root_dir = function(...) end` |
| markdown | grammarly-languageserver | `cmd = { 'grammarly-languageserver', '--stdio' }, filetypes = {'markdown'}, root_markers = {'.git'}, init_options = {...}` |
| python | pylsp | `cmd = { 'pylsp' }, filetypes = {'python'}, root_markers = {'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git'}` |
| kcl | kcl-language-server | `cmd = { 'kcl-language-server' }, filetypes = {'kcl'}, root_markers = {'.git'}` |
| text, tex, org | textlsp | `cmd = { 'textlsp' }, filetypes = {'text', 'tex', 'org'}, root_markers = {'.git'}, settings = {...}` |
| brs | bsc | `cmd = { 'bsc', '--lsp', '--stdio' }, filetypes = {'brs'}, root_markers = {'makefile', 'Makefile', '.git'}` |
| elm | elm-language-server | `cmd = { 'elm-language-server' }, filetypes = {'elm'}, init_options = {...}, root_dir = function(...) end` |
| ss | snakeskin-cli | `cmd = { 'snakeskin-cli', 'lsp', '--stdio' }, filetypes = {'ss'}, root_markers = {'package.json'}` |
| asciidoc, markdown, text, tex, rst, html, xml | vale-ls | `cmd = { 'vale-ls' }, filetypes = {'asciidoc', 'markdown', 'text', 'tex', 'rst', 'html', 'xml'}, root_markers = {'.vale.ini'}` |
| cypher | cypher-language-server | `cmd = { 'cypher-language-server', '--stdio' }, filetypes = {'cypher'}, root_markers = {'.git'}` |
| robot | robotframework_ls | `cmd = { 'robotframework_ls' }, filetypes = {'robot'}, root_markers = {'robotidy.toml', 'pyproject.toml', 'conda.yaml', 'robot.yaml', '.git'}` |
| msbuild | dotnet | `cmd = { 'dotnet', host_dll_name }, filetypes = {'msbuild'}, init_options = {...}, root_dir = function(...) end` |
| fsd | facility-language-server | `cmd = { 'facility-language-server' }, filetypes = {'fsd'}, root_markers = {'.git'}` |
| javascript, typescript | quick-lint-js | `cmd = { 'quick-lint-js', '--lsp-server' }, filetypes = {'javascript', 'typescript'}, root_markers = {'package.json', 'jsconfig.json', '.git'}` |
| javascript, javascriptreact, typescript, typescriptreact | cssmodules-language-server | `cmd = { 'cssmodules-language-server' }, filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}, root_markers = {'package.json'}` |
| roc | roc_language_server | `cmd = { 'roc_language_server' }, filetypes = {'roc'}, root_markers = {'.git'}` |
| swift, objc, objcpp, c, cpp | sourcekit-lsp | `cmd = { 'sourcekit-lsp' }, filetypes = {'swift', 'objc', 'objcpp', 'c', 'cpp'}, root_dir = function(...) end` |
| microcad | microcad-lsp | `cmd = { 'microcad-lsp', '--stdio' }, filetypes = {'microcad'}, root_markers = {'.git'}` |
| elixir, eelixir, heex, surface | lexical | `cmd = { 'lexical' }, filetypes = {'elixir', 'eelixir', 'heex', 'surface'}, root_markers = {'mix.exs', '.git'}` |
| atlas-* | atlas | `cmd = { 'atlas', 'tool', 'lsp', '--stdio' }, filetypes = {'atlas-*'}, root_markers = {'atlas.hcl'}` |
| agentscript | agentscript-lsp | `cmd = { 'agentscript-lsp', '--stdio' }, filetypes = {'agentscript'}, root_markers = {'package.json', '.git'}` |
| agda | als | `cmd = { 'als' }, filetypes = {'agda'}, root_dir = function(...) end` |
| javascript, html | lwc-language-server | `cmd = { 'lwc-language-server', '--stdio' }, filetypes = {'javascript', 'html'}, root_markers = {'sfdx-project.json'}, init_options = {...}` |
| python, cpp | python | `cmd = { 'python', '-m', 'ffi_navigator.langserver' }, filetypes = {'python', 'cpp'}, root_markers = {'pyproject.toml', '.git'}` |
| yaml.ansible | ansible-language-server | `cmd = { 'ansible-language-server', '--stdio' }, filetypes = {'yaml.ansible'}, root_markers = {'ansible.cfg', '.ansible-lint'}, settings = {...}` |
| go, gomod | golangci-lint-langserver | `cmd = { 'golangci-lint-langserver' }, filetypes = {'go', 'gomod'}, root_markers = {'.golangci.yml', '.golangci.yaml', '.golangci.toml', '.golangci.json', 'go.work', 'go.mod', '.git'}, init_options = {...}` |
| yaml | gh-actions-language-server | `cmd = { 'gh-actions-language-server', '--stdio' }, filetypes = {'yaml'}, init_options = {...}, root_dir = function(...) end` |
| tiltfile | tilt | `cmd = { 'tilt', 'lsp', 'start' }, filetypes = {'tiltfile'}, root_markers = {'.git'}` |
| markdown | rumdl | `cmd = { 'rumdl', 'server' }, filetypes = {'markdown'}, root_markers = {'.git'}` |
| yang | yang-language-server | `cmd = { 'yang-language-server' }, filetypes = {'yang'}, root_markers = {'.git'}` |
| mdx | mdx-language-server | `cmd = { 'mdx-language-server', '--stdio' }, filetypes = {'mdx'}, root_markers = {'package.json'}, settings = {...}, init_options = {...}` |
| fortran | fortitude | `cmd = { 'fortitude', 'server' }, filetypes = {'fortran'}, root_markers = {'fpm.toml', 'fortitude.toml', '.fortitude.toml', '.git'}, settings = {...}` |
| astro | astro | `cmd = function(dispatchers), filetypes = {'astro'}, root_markers = {'package.json', 'tsconfig.json', 'jsconfig.json', '.git'}, init_options = {...}` |
| termux_language_server | termux-language-server | `cmd = { 'termux-language-server' }, root_dir = function(...) end` |
| ruby, eruby | ruby_lsp | `cmd = function(dispatchers), filetypes = {'ruby', 'eruby'}, root_markers = {'Gemfile', '.git'}, init_options = {...}` |
| bzl | plz | `cmd = { 'plz', 'tool', 'lps' }, filetypes = {'bzl'}, root_markers = {'.plzconfig'}` |
| move | move-analyzer | `cmd = { 'move-analyzer' }, filetypes = {'move'}, root_markers = {'Move.toml'}` |
| clar, clarity | clarinet | `cmd = { 'clarinet', 'lsp' }, filetypes = {'clar', 'clarity'}, root_markers = {'Clarinet.toml'}` |
| groovy | groovy-language-server | `cmd = { 'groovy-language-server' }, filetypes = {'groovy'}, root_markers = {'Jenkinsfile', '.git'}` |
| mlir | buddy-lsp-server | `cmd = { 'buddy-lsp-server' }, filetypes = {'mlir'}, root_markers = {'.git'}` |
| yaml | vscode-home-assistant | `cmd = { 'vscode-home-assistant', '--stdio' }, filetypes = {'yaml'}, root_markers = {'configuration.yaml', 'configuration.yml'}` |
| cue | cue | `cmd = { 'cue', 'lsp' }, filetypes = {'cue'}, root_markers = {'cue.mod', '.git'}` |
| helm, yaml.helm-values | helm_ls | `cmd = { 'helm_ls', 'serve' }, filetypes = {'helm', 'yaml.helm-values'}, root_markers = {'Chart.yaml'}` |
| r | air | `cmd = { 'air', 'language-server' }, filetypes = {'r'}, root_markers = {'air.toml', '.air.toml', '.git'}` |
| lua | emmylua_ls | `cmd = { 'emmylua_ls' }, filetypes = {'lua'}, settings = {...}` |
| spec | rpm_lsp_server | `cmd = { 'rpm_lsp_server', '--stdio' }, filetypes = {'spec'}, root_markers = {'.git'}, settings = {...}` |
| tcl, sdc, xdc, upf | tclsp | `cmd = { 'tclsp' }, filetypes = {'tcl', 'sdc', 'xdc', 'upf'}, root_markers = {'tclint.toml', '.tclint', 'pyproject.toml', '.git'}` |
| veryl | veryl-ls | `cmd = { 'veryl-ls' }, filetypes = {'veryl'}, root_markers = {'.git'}` |
| cir | cir-lsp-server | `cmd = { 'cir-lsp-server' }, filetypes = {'cir'}, root_markers = {'.git'}` |
| nix | statix | `cmd = { 'statix', 'check', '--stdin' }, filetypes = {'nix'}, root_markers = {'flake.nix', '.git'}` |
| dart | dart | `cmd = { 'dart', 'language-server', '--protocol=lsp' }, filetypes = {'dart'}, root_markers = {'pubspec.yaml'}, settings = {...}, init_options = {...}` |
| tex, plaintex, bib | texlab | `cmd = { 'texlab' }, filetypes = {'tex', 'plaintex', 'bib'}, root_markers = {'.git', '.latexmkrc', 'latexmkrc', '.texlabroot', 'texlabroot', 'Tectonic.toml'}, settings = {...}` |
| typos_lsp | typos-lsp | `cmd = { 'typos-lsp' }, root_markers = {'typos.toml', '_typos.toml', '.typos.toml', 'pyproject.toml', 'Cargo.toml'}, settings = {...}` |
| hoon | hoon-language-server | `cmd = { 'hoon-language-server' }, filetypes = {'hoon'}, root_markers = {'.git'}` |
| sql | sqruff | `cmd = { 'sqruff', 'lsp' }, filetypes = {'sql'}, root_markers = {'.sqruff', '.git'}` |
| pest | pest-language-server | `cmd = { 'pest-language-server' }, filetypes = {'pest'}, root_markers = {'.git'}` |
| kdl | kdl-lsp | `cmd = { 'kdl-lsp' }, filetypes = {'kdl'}, root_markers = {'.git'}` |
| python | basedpyright-langserver | `cmd = { 'basedpyright-langserver', '--stdio' }, filetypes = {'python'}, root_markers = {'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git'}, settings = {...}` |
| http | kulala-ls | `cmd = { 'kulala-ls', '--stdio' }, filetypes = {'http'}, root_markers = {'.git'}` |
| solidity | solang | `cmd = { 'solang', 'language-server', '--target', 'evm' }, filetypes = {'solidity'}, root_markers = {'.git'}` |
| javascript, javascriptreact | flow | `cmd = function(dispatchers), filetypes = {'javascript', 'javascriptreact'}, root_markers = {'.flowconfig'}` |
| rego | regols | `cmd = { 'regols' }, filetypes = {'rego'}, root_dir = function(...) end` |
| cspell_ls | cspell-lsp | `cmd = { 'cspell-lsp', '--stdio' }, root_markers = {'.git', 'cspell.json', '.cspell.json', 'cspell.json', '.cSpell.json', 'cSpell.json', 'cspell.config.js', 'cspell.config.cjs', 'cspell.config.json', 'cspell.config.yaml', 'cspell.config.yml', 'cspell.yaml', 'cspell.yml'}` |
| proto, buf-config | buf | `cmd = { 'buf', 'lsp', 'serve', '--log-format=text' }, filetypes = {'proto', 'buf-config'}, root_markers = {'buf.yaml', '.git'}` |
| dot | dot-language-server | `cmd = { 'dot-language-server', '--stdio' }, filetypes = {'dot'}, root_markers = {'.git'}` |
| proto | protols | `cmd = { 'protols' }, filetypes = {'proto'}, root_markers = {'.git'}` |
| flux | flux-lsp | `cmd = { 'flux-lsp' }, filetypes = {'flux'}, root_markers = {'.git'}` |
| typespec | tsp-server | `cmd = { 'tsp-server', '--stdio' }, filetypes = {'typespec'}, root_markers = {'tspconfig.yaml', '.git'}` |
| mlir | mlir-lsp-server | `cmd = { 'mlir-lsp-server' }, filetypes = {'mlir'}, root_markers = {'.git'}` |
| ecsact | ecsact_lsp_server | `cmd = { 'ecsact_lsp_server', '--stdio' }, filetypes = {'ecsact'}, root_markers = {'.git'}` |
| perl | perlnavigator | `cmd = { 'perlnavigator' }, filetypes = {'perl'}, root_markers = {'.git'}` |
| ruby, go, javascript, typescript, typescriptreact, javascriptreact, rust, lua, python, java, cpp, c, php, cs, kotlin, swift, scala, vue, svelte, html, css, scss, json, yaml | npx | `cmd = { 'npx', '--@gitlab-org:registry=https://gitlab.com/api/v4/packages/npm/', '@gitlab-org/gitlab-lsp', '--stdio' }, filetypes = {'ruby', 'go', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'rust', 'lua', 'python', 'java', 'cpp', 'c', 'php', 'cs', 'kotlin', 'swift', 'scala', 'vue', 'svelte', 'html', 'css', 'scss', 'json', 'yaml'}, root_markers = {'.git'}, settings = {...}, init_options = {...}` |
| cobol | cobol-language-support | `cmd = { 'cobol-language-support' }, filetypes = {'cobol'}, root_markers = {'.git'}` |
| slint | slint-lsp | `cmd = { 'slint-lsp' }, filetypes = {'slint'}, root_markers = {'.git'}` |
| elixir, eelixir, heex | dexter | `cmd = { 'dexter', 'lsp' }, filetypes = {'elixir', 'eelixir', 'heex'}, root_markers = {'.dexter/dexter.db', '.dexter.db', '.git', 'mix.exs'}, init_options = {...}` |
| systemverilog, verilog | verible-verilog-ls | `cmd = { 'verible-verilog-ls' }, filetypes = {'systemverilog', 'verilog'}, root_markers = {'verible.filelist', '.git'}` |
| json, jsonc | jsonls | `cmd = function(dispatchers), filetypes = {'json', 'jsonc'}, root_markers = {'.git'}, init_options = {...}` |
| arduino | arduino-language-server | `cmd = { 'arduino-language-server' }, filetypes = {'arduino'}, root_dir = function(...) end` |
| turtle, ttl | node | `cmd = { 'node', full_path, '--stdio' }, filetypes = {'turtle', 'ttl'}, root_markers = {'.git'}` |
| php | phan | `cmd = cmd, filetypes = {'php'}, root_dir = function(...) end` |
| bitbake | bitbake-language-server | `cmd = { 'bitbake-language-server' }, filetypes = {'bitbake'}, root_markers = {'.git'}` |
| kakehashi | kakehashi | `cmd = { 'kakehashi' }, root_markers = {'kakehashi.toml', '.git'}` |
| dfy, dafny | dafny | `cmd = { 'dafny', 'server' }, filetypes = {'dfy', 'dafny'}, root_markers = {'.git'}` |
| yaml.openapi, json.openapi | vacuum | `cmd = { 'vacuum', 'language-server' }, filetypes = {'yaml.openapi', 'json.openapi'}, root_markers = {'.git'}` |
| yaml, json, yml | spectral-language-server | `cmd = { 'spectral-language-server', '--stdio' }, filetypes = {'yaml', 'json', 'yml'}, root_markers = {'.spectral.yaml', '.spectral.yml', '.spectral.json', '.spectral.js'}, settings = {...}` |
| html, ruby, eruby, blade, php | stimulus-language-server | `cmd = { 'stimulus-language-server', '--stdio' }, filetypes = {'html', 'ruby', 'eruby', 'blade', 'php'}, root_markers = {'Gemfile', '.git'}` |
| terraform | tflint | `cmd = { 'tflint', '--langserver' }, filetypes = {'terraform'}, root_markers = {'.terraform', '.git', '.tflint.hcl'}` |
| html, eruby | herb-language-server | `cmd = { 'herb-language-server', '--stdio' }, filetypes = {'html', 'eruby'}, root_markers = {'Gemfile', '.git'}` |
| ungrammar | ungrammar-languageserver | `cmd = { 'ungrammar-languageserver', '--stdio' }, filetypes = {'ungrammar'}, root_markers = {'.git'}, settings = {...}` |
| fsharp | dotnet | `cmd = { 'dotnet', 'FSharpLanguageServer.dll' }, filetypes = {'fsharp'}, settings = {...}, init_options = {...}, root_dir = function(...) end` |
| julia | julia | `cmd = cmd, filetypes = {'julia'}` |
| earthfile | earthlyls | `cmd = { 'earthlyls' }, filetypes = {'earthfile'}, root_markers = {'Earthfile'}` |
| markdown | mpls | `cmd = { 'mpls', '--theme', 'dark', '--enable-emoji', '--enable-footnotes', '--no-auto' }, filetypes = {'markdown'}, root_markers = {'.marksman.toml', '.git'}` |
| glsl, vert, tesc, tese, frag, geom, comp | glsl_analyzer | `cmd = { 'glsl_analyzer' }, filetypes = {'glsl', 'vert', 'tesc', 'tese', 'frag', 'geom', 'comp'}, root_markers = {'.git'}` |
| sql, mysql | sql-language-server | `cmd = { 'sql-language-server', 'up', '--method', 'stdio' }, filetypes = {'sql', 'mysql'}, root_markers = {'.sqllsrc.json'}, settings = {...}` |
| python | ruff | `cmd = { 'ruff', 'server' }, filetypes = {'python'}, root_markers = {'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git'}, settings = {...}` |
| ruby | srb | `cmd = { 'srb', 'tc', '--lsp' }, filetypes = {'ruby'}, root_markers = {'Gemfile', '.git'}` |
| javascript, javascriptreact, typescript, typescriptreact, vue, svelte, astro | oxlint | `cmd = function(dispatchers), filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'astro'}, settings = {...}, root_dir = function(...) end` |
| lua | stylua-3p-language-server | `cmd = { 'stylua-3p-language-server' }, filetypes = {'lua'}, root_markers = {'.stylua.toml', 'stylua.toml'}` |
| proto | pbls | `cmd = { 'pbls' }, filetypes = {'proto'}, root_markers = {'.pbls.toml', '.git'}` |
| purescript | purescript-language-server | `cmd = { 'purescript-language-server', '--stdio' }, filetypes = {'purescript'}, root_markers = {'bower.json', 'flake.nix', 'psc-package.json', 'shell.nix', 'spago.dhall', 'spago.yaml'}` |
| javascript, javascriptreact, typescript, typescriptreact | ts_ls | `cmd = function(dispatchers), filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}, root_markers = {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock'}, init_options = {...}, root_dir = function(...) end` |

## Deprecated Servers

| LSP Server | Notes |
| --- | --- |
| volar | Superseded — use vue-language-server or vtsls. |
| systemd_ls | Superseded by systemd-lsp. |
| vscoqtop | Superseded by vsrocqtop. |
| pony_language_server | Superseded by pony-lsp. |
| ruff-lsp | Superseded by `ruff server` LSP (built-in). |
| tsgo | No longer maintained. |
