return 	{
  {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
	  {
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		opts = {
		  select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			selection_modes = {
			  ['@parameter.outer'] = 'v', -- charwise
			  ['@function.outer'] = 'V', -- linewise
			  --['@function.outer'] = '<c-v>', -- blockwise
			  ['@class.outer'] = '<c-v>', -- blockwise
			},
		  },
		},
	  },
	  {
		"nvim-treesitter/nvim-treesitter-context",
		opts = { enabled = true, mode = "topline", line_numbers = true },
	  }
	},
	config = require("plugins.configs.treesitter").config
  },
  {
	'MeanderingProgrammer/treesitter-modules.nvim',
	enabed = false,
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	opts = {
	  highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	  },
	  incremental_selection = {
		enable = true,
		keymaps = {
		  init_selection = "<leader>ss",
		  node_incremental = "<leader>si",
		  scope_incremental = "<leader>sc",
		  node_decremental = "<leader>sd",
		},
	  },
	},
  },
}
