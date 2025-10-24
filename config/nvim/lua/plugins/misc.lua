return {
  {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
	  start_in_insert = true,
	},
  },
  { "tpope/vim-repeat" }, -- improve . operator to repeat operations
  { "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} }, -- helper for folding chunk of code
  { "mbbill/undotree" }, -- it gives an undotree to revert or navigate through changes
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
	  })

	end
  }
}
