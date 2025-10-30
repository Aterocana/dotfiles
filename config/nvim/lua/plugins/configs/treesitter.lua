local M = {}
M.config = function ()
  local ts = require('nvim-treesitter')

  ts.install({
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
	"regex"
  })
end

return M
