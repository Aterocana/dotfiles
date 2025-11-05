return {
  { "lewis6991/gitsigns.nvim" }, -- git enhancements
  {
	'sindrets/diffview.nvim',
	dependencies = 'nvim-lua/plenary.nvim',
  },
  { "tpope/vim-fugitive" },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
}
