return 	{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
	{"nvim-treesitter/nvim-treesitter-textobjects"},
	{ "nvim-treesitter/nvim-treesitter-context",
	  opts = { enabled = true, mode = "topline", line_numbers = true }}
  },
  config = require("plugins.configs.treesitter").config
}
