return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = {
	{ 'nvim-lua/plenary.nvim' },
	{
	  "isak102/telescope-git-file-history.nvim",
	  dependencies = { "tpope/vim-fugitive" }
	},
  },
  config = function ()
	pcall(require("telescope").load_extension, "fzf")
	local actions = require("telescope.actions")
	require("telescope").setup({
	  defaults = {
		mappings = {
		  n = {
			["<C-C>"] = actions.close,
		  },
		},
	  },
	})
  end,
}