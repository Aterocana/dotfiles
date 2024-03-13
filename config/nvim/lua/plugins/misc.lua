return {
	{ "christoomey/vim-tmux-navigator" },
	{ "tpope/vim-fugitive" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000 },
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "mbbill/undotree" },
	{
		"iamcco/markdown-preview.nvim",
		dependencies = {
			"zhaozg/vim-diagram",
			"aklt/plantuml-syntax",
		},
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
		cmd = { "MarkdownPreview" },
	},
}
