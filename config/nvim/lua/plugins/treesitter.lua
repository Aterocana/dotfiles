return 	{
  {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
	  {"nvim-treesitter/nvim-treesitter-textobjects", branch = "main"},
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
		--disable = function(lang, buf)
		--  local max_filesize = 100 * 1024 -- 100 KB
		--  local ok, stats = pcall(vim.fs_stat, vim.api.nvim_buf_get_name(buf))
		--  if ok and stats and stats.size > max_filesize then
		--	return true
		--  end
		--end,
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
