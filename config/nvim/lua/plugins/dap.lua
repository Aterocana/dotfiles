return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"Joakker/lua-json5",
			build = "./install.sh"
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			require('dap-go').setup {
				-- Additional dap configurations can be added.
				-- dap_configurations accepts a list of tables where each entry
				-- represents a dap configuration. For more details do:
				-- :help dap-configuration
				dap_configurations = {
					{
						-- Must be "go" or it will be ignored by the plugin
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				-- delve configurations
				delve = {
					-- the path to the executable dlv which will be used for debugging.
					-- by default, this is the "dlv" executable on your PATH.
					path = "dlv",
					-- time to wait for delve to initialize the debug session.
					-- default to 20 seconds
					initialize_timeout_sec = 20,
					-- a string that defines the port to start delve debugger.
					-- default to string "${port}" which instructs nvim-dap
					-- to start the process in a random available port
					port = "${port}",
					-- additional args to pass to dlv
					args = {},
					-- the build flags that are passed to delve.
					-- defaults to empty string, but can be used to provide flags
					-- such as "-tags=unit" to make sure the test suite is
					-- compiled during debugging, for example.
					-- passing build flags using args is ineffective, as those are
					-- ignored by delve in dap mode.
					build_flags = "",
				},
			}
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
			vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
			vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
			vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
			vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
			vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
			vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end)

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
	{"leoluz/nvim-dap-go", dependencies = {"mfussenegger/nvim-dap"}},
	{ "rcarriga/nvim-dap-ui", dependencies = { 
		{ "mfussenegger/nvim-dap" },
		{ "nvim-neotest/nvim-nio" },
	} }
}
