return {
  {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = true
	-- use opts = {} for passing setup options
	-- this is equalent to setup({}) function
  },
  { -- a semantic navigator for current buffer
	'stevearc/aerial.nvim',
	config = require("plugins.configs.aerial").setup,
	dependencies = {
	  "nvim-treesitter/nvim-treesitter",
	  "nvim-tree/nvim-web-devicons"
	},
  },
  {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
  }
}
