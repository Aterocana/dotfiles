local M = {}

local style = function()
  vim.fn.sign_define('DapBreakpoint',
  {
    text = '⚪',
    texthl = 'DapBreakpointSymbol',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
  })

  vim.fn.sign_define('DapStopped',
  {
    text = '🔴',
    texthl = 'yellow',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
  })
  vim.fn.sign_define('DapBreakpointRejected',
  {
    text = '⭕',
    texthl = 'DapStoppedSymbol',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
  })
end

local listeners = function(dap, dapui)
  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
end

local keymaps = function(dap, dapui)
  vim.keymap.set('n', '<F5>', function()
    require('dap.ext.vscode').json_decode = require 'json5'.parse
    require("dap.ext.vscode").load_launchjs(".vscode/launch_vim.json", {})
    dap.continue()
  end)
  vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = "debug: step over" })
  vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = "debug: step into" })
  vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = "debug: step out" })

  vim.keymap.set('n', '<Leader>B', function() require('dap').toggle_breakpoint() end,
  { desc = "debug: toggle a [B]reakpoint" })

  vim.keymap.set('n', '<Leader>lp', function()
    require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
  end,
  { desc = "debug: set a breakpoint with a [L]og [P]oint message" })

  vim.keymap.set('n', '<Leader>cB', function()
    require('dap').clear_breakpoints()
  end,
  { desc = "debug: clear all breakpoints" })

  vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = "debug: repl open" })
  vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = "debug: run last" })
  vim.keymap.set({ 'n', 'v' }, '<Leader>dw', function()
    require('dapui').eval(nil, { enter = true })
  end, { noremap = true, silent = true, desc = "debug: add word under cursor to Watches" })

  vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end, { desc = "debug UI: toggle" })
  vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = "debug UI: widgets" })
  vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
  end, { desc = "debug UI: widgets" })
  vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end, { desc = "debug UI: widgets" })
  vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end, { desc = "debug UI: widgets" })
end

M.config = function()
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
  style()
  dapui.setup({
    expand_lines = true,
    controls = {
      element = "repl",
      enabled = true,
      icons = {
	disconnect = "",
	pause = "",
	play = "",
	run_last = "",
	step_back = "",
	step_into = "",
	step_out = "",
	step_over = "",
	terminate = ""
      }
    },
    floating = { border = "rounded" },
    -- Set dapui window
    render = {
      max_type_length = 60,
      max_value_lines = 200,
    },
    -- Only one layout: just the "scopes" (variables) list at the bottom
    layouts = {
      {
	elements = {
	  { id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
	},
	size = 15,                -- height in lines (adjust to taste)
	position = "bottom",      -- "left", "right", "top", "bottom"
      },
    },
  })
  listeners(dap, dapui)
  keymaps(dap, dapui)
end

return M
