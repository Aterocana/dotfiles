return {
	{ "christoomey/vim-tmux-navigator" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000 },
	{ 'akinsho/toggleterm.nvim', version = "*", config = true },
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function ()
			require("spectre").setup({})
			vim.keymap.set('n', '<C-S>', '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre"
			})
			vim.keymap.set('n', '<C-s>', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
				desc = "Search current word"
			})
			-- vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			-- 	desc = "Search current word"
			-- })
			-- vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			-- 	desc = "Search on current file"
			-- })
		end
	},
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{ "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} },
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{
				"isak102/telescope-git-file-history.nvim",
				dependencies = { "tpope/vim-fugitive" }
			},
		},
		config = function ()
			pcall(require("telescope").load_extension, "fzf")
		end
	},
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
}
