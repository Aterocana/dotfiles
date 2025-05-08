return {
  {
	"ray-x/go.nvim",
	dependencies = {
	  {"ray-x/guihua.lua", run="cd lua/fzy && make"},
	  {"neovim/nvim-lspconfig"},
	  {"nvim-treesitter/nvim-treesitter"},
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
	"fredrikaverpil/godoc.nvim",
	version = "*",
	dependencies = {
	  { "nvim-telescope/telescope.nvim" }, -- optional
	  {
		"nvim-treesitter/nvim-treesitter",
		opts = {
		  ensure_installed = { "go" },
		},
	  },
	},
	build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
	cmd = { "GoDoc" }, -- optional
	opts = {
	  window = {
		type = "vsplit", -- split | vsplit
	  },
	  picker = {
		type = "telescope", -- native (vim.ui.select) | telescope | snacks | mini | fzf_lua

		-- see respective picker in lua/godoc/pickers for available options
		telescope = {},
	  },
	},
  },
}
