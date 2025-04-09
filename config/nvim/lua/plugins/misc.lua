return {
  { "akinsho/toggleterm.nvim", version = "*", config = true }, -- terminal embedded int Nvim
  { "echasnovski/mini.surround", version = '0.15', config = function ()
	require("mini.surround").setup()
  end },
  { "tpope/vim-repeat" }, -- improve . operator to repeat operations
  { "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} }, -- helper for folding chunk of code
  { "mbbill/undotree" }, -- it gives an undotree to revert or navigate through changes
  {	"stevearc/dressing.nvim",
	config = function ()
	  require("dressing").setup()
	end
  },
  {	"stevearc/overseer.nvim",
	config = function ()
	  require("overseer").setup()
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
}
