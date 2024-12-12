return {
	{ "akinsho/toggleterm.nvim", version = "*", config = true }, -- terminal embedded int Nvim
	{ "lewis6991/gitsigns.nvim" }, -- git enhancements
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	}, -- managing favourite files
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" }, -- shortcut to work with brackets, parenthesis
	{ "tpope/vim-repeat" }, -- improve . operator to repeat operations
	{ "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} }, -- helper for folding chunk of code
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
	{ "mbbill/undotree" }, -- it gives an undotree to revert or navigate through changes
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
	}, -- syntax highlighter 
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
	}, -- toggle a todo list
}
