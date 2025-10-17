return {
  {
	"saghen/blink.cmp",
	version = '1.*',
	opts_extend = {
	  "sources.completion.enabled_providers",
	  "sources.compat",
	  "sources.default",
	},
	dependencies = {
	  {
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = require("plugins.configs.snippets").config,
	  },
	},
	event = { "InsertEnter", "CmdlineEnter" },
	opts = require('plugins.configs.cmp').opts,
  },
  { -- a semantic navigator for current buffer
	'stevearc/aerial.nvim',
	config = require("plugins.configs.aerial").setup,
	dependencies = {
	  "nvim-treesitter/nvim-treesitter",
	  "nvim-tree/nvim-web-devicons"
	},
  },
}
