return {
  { "akinsho/toggleterm.nvim", version = "*", config = true }, -- terminal embedded int Nvim
  --{ "echasnovski/mini.surround", version = '0.15', config = function ()
  --  require("mini.surround").setup()
  --end },
  { "tpope/vim-repeat" }, -- improve . operator to repeat operations
  { "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} }, -- helper for folding chunk of code
  { "mbbill/undotree" }, -- it gives an undotree to revert or navigate through changes
  {	"stevearc/dressing.nvim",
	config = function ()
	  require("dressing").setup()
	end
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
	  "nvim-telescope/telescope.nvim", -- optional
	  "ibhagwan/fzf-lua" -- optional
	},
	config = function ()
	  require('yaml_nvim').setup({ ft = { "yaml" } })
	end
  },

  {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	config = function ()
	  require('render-markdown').setup({
		completions = { lsp = { enabled = true } },
	  })

	end
  }
}
