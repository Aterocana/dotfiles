return {
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
		"atiladefreitas/dooing",
		config = function()
			require("dooing").setup({
				-- Core settings
				save_path = vim.fn.stdpath('data') .. '/dooing_todos.json',

				-- Window appearance
				window = {
					width = 60,         -- Width of the floating window
					height = 30,        -- Height of the floating window
					border = 'rounded', -- Border style
				},

				-- Icons
				icons = {
					pending = '○',      -- Pending todo icon
					done = '✓',        -- Completed todo icon
				},

				-- Keymaps
				keymaps = {
					toggle_window = "<leader>td", -- Toggle the main window
					new_todo = "i",              -- Add a new todo
					toggle_todo = "x",           -- Toggle todo status
					delete_todo = "d",           -- Delete the current todo
					delete_completed = "D",      -- Delete all completed todos
					close_window = "q",          -- Close the window
					toggle_help = "?",           -- Toggle help window
					toggle_tags = "t",           -- Toggle tags window
					clear_filter = "c",          -- Clear active tag filter
				},
			})
		end,
		keys = {
			{ "<leader>td", desc = "Toggle Todo List" },
		},
	},
}
