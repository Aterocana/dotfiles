local nvim_dap_opts = require("plugins.configs.nvim_dap")
return {
  {
	"mfussenegger/nvim-dap",
	dependencies = {
	  {
		"Joakker/lua-json5",
		build = "./install.sh",
	  },
	},
	config = nvim_dap_opts.config,
  },
  { "leoluz/nvim-dap-go", dependencies = {"mfussenegger/nvim-dap"} },
  {
	"rcarriga/nvim-dap-ui", dependencies = {
	  "mfussenegger/nvim-dap",
	  "nvim-neotest/nvim-nio",
	  "theHamsta/nvim-dap-virtual-text",
	},
  },
  {
	"nvim-neotest/neotest",
	dependencies = {
	  "nvim-neotest/nvim-nio",
	  "nvim-lua/plenary.nvim",
	  "antoinemadec/FixCursorHold.nvim",
	  "fredrikaverpil/neotest-golang"
	},
	config = function ()
	  require("neotest").setup({
		adapters = {
		  require("neotest-golang")({}),
		},
	  })
	end
  },
}
