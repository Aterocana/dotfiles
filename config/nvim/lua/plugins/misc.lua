return {
  { "akinsho/toggleterm.nvim", version = "*", config = true }, -- terminal embedded int Nvim
  { "lewis6991/gitsigns.nvim" }, -- git enhancements
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" }, -- shortcut to work with brackets, parenthesis
  { "tpope/vim-repeat" }, -- improve . operator to repeat operations
  { "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} }, -- helper for folding chunk of code
  { "mbbill/undotree" }, -- it gives an undotree to revert or navigate through changes
  {
	"stevearc/dressing.nvim",
	config = function ()
	  require("dressing").setup()
	end
  },
  {
	'stevearc/overseer.nvim',
	config = function ()
	  require("overseer").setup()
	end
  }
}
