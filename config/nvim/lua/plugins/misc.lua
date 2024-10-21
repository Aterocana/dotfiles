return {
	{
		"code-biscuits/nvim-biscuits",
		dependencies = {"nvim-treesitter/nvim-treesitter"},
		build = ":TSUpdate"
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{ "lewis6991/gitsigns.nvim" },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{ "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} },
	{
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
	},
	{ "mbbill/undotree" },
	{
		"stevearc/dressing.nvim",
		config = function ()
			require("dressing").setup()
		end
	},
	{
		"RRethy/vim-illuminate",
		config = function ()
			require("illuminate").configure({
				under_cursor = false,
				filetypes_denylist = {
					"DressingSelect",
					"Outline",
					"TelescopePrompt",
					"harpoon",
				},
			})
		end
	},
	{
		"mbbill/undotree",
	},
}
