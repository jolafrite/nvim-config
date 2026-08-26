-- Bootstrap: run vim.pack.add for each custom plugin so this file is
-- self-contained (idempotent — safe to call alongside init.lua's adds).
require("plugins.conform")
require("plugins.kotlin")
require("plugins.lens")
require("plugins.lightbulb")
require("plugins.symbol-usage")
require("plugins.workspace-diagnostics")

require("conform").setup({
  formatters_by_ft = {
    go = { "gocondense" },
  },
  formatters = {
    gocondense = {
      command = "gocondense",
      stdin = true,
    },
  },
})

require("kotlin").setup({
  root_markers = {
    "gradlew",
    ".git",
    "mvnw",
    "settings.gradle",
    "build.gradle",
    "build.gradle.kts",
    "pom.xml",
    "mvnw",
  },

  jre_path = nil,

  jdk_for_symbol_resolution = nil,

  jvm_args = {
    "-Xmx10g",
  },

  inlay_hints = {
    enabled = true,
    parameters = true,
    parameters_compiled = true,
    parameters_excluded = false,
    types_property = true,
    types_variable = true,
    function_return = true,
    function_parameter = true,
    lambda_return = true,
    lambda_receivers_parameters = true,
    value_ranges = true,
    kotlin_time = true,
  },
})

require("lsp-lens").setup({
  sections = {
    definition = false,
    references = function(count)
      return "󰌹 Ref: " .. count
    end,
    implements = function(count)
      return "󰡱 Imp: " .. count
    end,
    git_authors = false,
  },
})

require("nvim-lightbulb").setup({
  autocmd = { enabled = true },
  sign = { enabled = true, text = "󰰀" },
  action_kinds = { "quickfix", "refactor" },
  ignore = {
    actions_without_kind = true,
  },
})

require("symbol-usage").setup({
  vt_position = "end_of_line",
  text_format = function(symbol)
    if symbol.references then
      local usage = symbol.references <= 1 and "usage" or "usages"
      local num = symbol.references == 0 and "no" or symbol.references
      return string.format(" 󰌹 %s %s", num, usage)
    else
      return ""
    end
  end,
})

require("workspace-diagnostics").setup({})