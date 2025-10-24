return {
  {
	"ray-x/go.nvim",
	branch = "treesitter-main",
	dependencies = {
	  {"ray-x/guihua.lua", run="cd lua/fzy && make"},
	},
	events = {"CmdlineEnter"},
	ft = {"go", "gomod"},
	build = ':lua require("go.install").update_all_sync()',
  },
  {
	"olexsmir/gopher.nvim",
	ft = "go",
	-- branch = "develop", -- if you want develop branch
	-- keep in mind, it might break everything
	dependencies = {
	  "nvim-lua/plenary.nvim",
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
	build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
	cmd = { "GoDoc" }, -- optional
	opts = {
	  window = {
		type = "vsplit", -- split | vsplit
	  },
	  picker = {
		type = "fzf_lua", -- native (vim.ui.select) | telescope | snacks | mini | fzf_lua

		-- see respective picker in lua/godoc/pickers for available options
		telescope = {},
		fzf_lua = {},
	},
  },
},
}
