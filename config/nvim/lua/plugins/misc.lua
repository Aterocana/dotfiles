return {
  {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = true
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
  },
  {
	"tpope/vim-sleuth",
	event = "VeryLazy",
  },
  {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
	  start_in_insert = true,
	},
  },
  { "tpope/vim-repeat" }, -- improve . operator to repeat operations
  { "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} }, -- helper for folding chunk of code
  -- { "mbbill/undotree" }, -- it gives an undotree to revert or navigate through changes
  {
	"XXiaoA/atone.nvim",
	cmd = "Atone",
	opts = {
	  layout = {
		---@type "left"|"right"
		direction = "left",
		---@type "adaptive"|integer|number
		--- adaptive: exact the width of tree graph
		--- if number given is a float less than 1, the width is set to `vim.o.columns * that number`
		width = 0.25,
	  },
	  -- diff for the node under cursor
	  -- shown under the tree graph
	  diff_cur_node = {
		enabled = true,
		---@type number float less than 1
		--- The diff window's height is set to a specified percentage of the original (namely tree graph) window's height.
		split_percent = 0.3,
	  },
	  -- automatically update the buffer that the tree is attached to
	  -- only works for buffer whose buftype is <empty>
	  auto_attach = {
		enabled = true,
		excluded_ft = { "oil" },
	  },
	  keymaps = {
		tree = {
		  quit = { "<C-c>", "q" },
		  next_node = "j", -- support v:count
		  pre_node = "k", -- support v:count
		  undo_to = "<CR>",
		  help = { "?", "g?" },
		},
		auto_diff = {
		  quit = { "<C-c>", "q" },
		  help = { "?", "g?" },
		},
		help = {
		  quit_help = { "<C-c>", "q" },
		},
	  },
	  ui = {
		-- refer to `:h 'winborder'`
		border = "single",
	  },
	},
  },
  {
	'echasnovski/mini.hipatterns',
	version = '*',
	config = function ()
	  local hipatterns = require("mini.hipatterns")
	  hipatterns.setup({
		highlighters = {
		  hex_color = hipatterns.gen_highlighter.hex_color(),
		}
	  })

	end
  },
  {
	"cuducos/yaml.nvim",
	ft = { "yaml" }, -- optional
	dependencies = {
	  "nvim-treesitter/nvim-treesitter",
	},
	config = function ()
	  require('yaml_nvim').setup({ ft = { "yaml" } })
	end
  },
  {
	'MeanderingProgrammer/render-markdown.nvim',
	config = function ()
	  require('render-markdown').setup({
		completions = { lsp = { enabled = true } },
		preview = {
		  filetypes = { "markdown", "codecompanion" },
		  ignore_buftypes = {},
		},
	  })

	end
  },
  {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
	  require("tiny-inline-diagnostic").setup()
	  vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
	end,
  },
}
