return {
  {
	"mfussenegger/nvim-dap",
	dependencies = {
	  {
		"Joakker/lua-json5",
		build = "./install.sh",
	  },
	},
	config = function()
	  local dap, dapui = require("dap"), require("dapui")
	  require("dap-go").setup({
		dap_configuration = {
		  {
			type = "go",
			name = "debugger",
			mode = "exec",
			request = "attach",
		  },
		},
		delve = {
		  path = "dlv",
		  initialize_timeout_sec = 10,
		  port = "${port}",
		  args = {},
		  build_flags = "",
		},
	  })
	  dapui.setup()

	  dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	  end
	  dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	  end
	  dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	  end
	  dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	  end

	  vim.keymap.set('n', '<F5>', function()
		require('dap.ext.vscode').json_decode = require'json5'.parse
		require("dap.ext.vscode").load_launchjs(".vscode/launch_vim.json", {})
		dap.continue()
	  end)
	  vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
	  vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
	  vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
	  vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, {desc = "toggle a breakpoint"})
	  vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, {desc = "put a break point"})
	  vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, {desc = "set a breakpoint with a log point message"})
	  vim.keymap.set('n', '<Leader>cB', function() require('dap').clear_breakpoints() end, {desc = "clear all breakpoints"})
	  vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
	  vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
	  vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end, {desc = "toggle Debug UI"})

	  vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
		require('dap.ui.widgets').hover()
	  end)
	  vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
		require('dap.ui.widgets').preview()
	  end)
	  vim.keymap.set('n', '<Leader>df', function()
		local widgets = require('dap.ui.widgets')
		widgets.centered_float(widgets.frames)
	  end)
	  vim.keymap.set('n', '<Leader>ds', function()
		local widgets = require('dap.ui.widgets')
		widgets.centered_float(widgets.scopes)
	  end)
	end
  },
  { "leoluz/nvim-dap-go", dependencies = {"mfussenegger/nvim-dap"} },
  {
	"rcarriga/nvim-dap-ui", dependencies = {
	  "mfussenegger/nvim-dap",
	  "nvim-neotest/nvim-nio",
	},
  },
  {
	"nvim-neotest/neotest",
	dependencies = {
	  "nvim-neotest/nvim-nio",
	  "nvim-lua/plenary.nvim",
	  "antoinemadec/FixCursorHold.nvim",
	  "nvim-treesitter/nvim-treesitter",
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
