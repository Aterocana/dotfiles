return {
  { "akinsho/toggleterm.nvim", version = "*", config = true }, -- terminal embedded int Nvim
  { "tpope/vim-repeat" }, -- improve . operator to repeat operations
  { "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} }, -- helper for folding chunk of code
  { "mbbill/undotree" }, -- it gives an undotree to revert or navigate through changes
  {	"stevearc/dressing.nvim",
	enabled = false,
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
	"github/copilot.vim"
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
