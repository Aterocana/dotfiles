return {
  cmd = { "eslint-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
  },
  root_markers = {
    "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
    ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml",
    "package.json", ".git",
  },
  settings = {
    validate = "on",
    useFlatConfig = true,
    run = "onType",
    workingDirectory = { mode = "auto" },
  },
  handlers = {
    ["eslint/confirmESLintExecution"] = function() return 4 end,
    ["eslint/openDoc"] = function() return {} end,
    ["eslint/probeFailed"] = function() return {} end,
    ["eslint/noLibrary"] = function() return {} end,
  },
}
