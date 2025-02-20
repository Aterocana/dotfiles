return {
  {
	"ray-x/go.nvim",
	dependencies = {
	  "ray-x/guihua.lua",
	  "neovim/nvim-lspconfig",
	  "nvim-treesitter/nvim-treesitter",
	},
	events = {"CmdlineEnter"},
	ft = {"go", "gomod"},
	build = ':lua require("go.install").update_all_sync()',
  },
  {
	'edolphin-ydf/goimpl.nvim',
	dependencies = {
	  {'nvim-lua/plenary.nvim'},
	  {'nvim-lua/popup.nvim'},
	  {'nvim-telescope/telescope.nvim'},
	  {'nvim-treesitter/nvim-treesitter'},
	},
	config = function()
	  require'telescope'.load_extension'goimpl'
	end,
  },
  {
	"olexsmir/gopher.nvim",
	ft = "go",
	-- branch = "develop", -- if you want develop branch
	-- keep in mind, it might break everything
	dependencies = {
	  "nvim-lua/plenary.nvim",
	  "nvim-treesitter/nvim-treesitter",
	  "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
	},
	-- (optional) will update plugin's deps on every update
	build = function()
	  vim.cmd.GoInstallDeps()
	end,
	opts = {},
  },
  {
	"cademichael/gotest.nvim",
	dependencies = {
	  'nvim-treesitter/nvim-treesitter',
	  'nvim-telescope/telescope.nvim',
	},
	config = function()
	  -- defaults
	  vim.g.gotest = {
		test_cmd = "gotest -run ",
		preview_cutoff = 0,
		preview_width = 0.67
	  }
	  local goTest = require("gotest")
	  vim.keymap.set("n", "<Leader>tf", goTest.goFuncTester, {desc = "run a Go test"})
	  vim.keymap.set("n", "<Leader>tm", goTest.goModTester, {desc = "run a Go module test suite"})
	end
  },
}
