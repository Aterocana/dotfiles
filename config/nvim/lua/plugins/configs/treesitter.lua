local M = {}

local languages = {
  "go", "gomod", "gowork", "gosum", "gotmpl",
  "make",
  "comment",
  "proto",
  "dockerfile",
  "c",
  "bash",
  "javascript",
  "json",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "gitignore",
  "gitcommit",
  "toml",
  "yaml",
  "markdown",
  "markdown_inline",
  "mermaid",
  "regex",
}

M.config = function()
  require('nvim-treesitter').install(languages)

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      pcall(vim.treesitter.start, args.buf)
    end,
  })
end

return M
