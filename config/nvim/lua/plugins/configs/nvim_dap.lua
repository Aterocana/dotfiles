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
  local project_filetypes = {
    { marker = 'go.mod',       ft = 'go' },
    { marker = 'package.json', ft = 'javascript' },
  }

  vim.keymap.set('n', '<F5>', function()
    local ft = vim.bo.filetype
    if ft == '' or ft == 'oil' then
      local cwd = vim.fn.getcwd()
      for _, p in ipairs(project_filetypes) do
	if vim.fn.filereadable(cwd .. '/' .. p.marker) == 1 then
	  vim.b["dap-srcft"] = p.ft
	  break
	end
      end
    end
    dap.continue()
  end)
  vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "debug: step over" })
  vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "debug: step into" })
  vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "debug: step out" })

  vim.keymap.set('n', '<Leader>B', function() dap.toggle_breakpoint() end,
  { desc = "debug: toggle a [B]reakpoint" })

  vim.keymap.set('n', '<Leader>cb', function()
    dap.set_breakpoint(vim.fn.input('Condition: '))
  end, { desc = "debug: set a [c]onditional [b]reakpoint" })

  vim.keymap.set('n', '<Leader>lp', function()
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
  end,
  { desc = "debug: set a breakpoint with a [L]og [P]oint message" })

  vim.keymap.set('n', '<Leader>cB', function()
    dap.clear_breakpoints()
  end,
  { desc = "debug: clear all breakpoints" })

  vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = "debug: repl open" })
  vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = "debug: run last" })
  vim.keymap.set({ 'n', 'v' }, '<Leader>dw', function()
    dapui.eval(nil, { enter = true })
  end, { noremap = true, silent = true, desc = "debug: add word under cursor to Watches" })

  vim.keymap.set('n', '<Leader>du', function() dapui.toggle() end, { desc = "debug UI: toggle" })
  vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    dap.ui.widgets.hover()
  end, { desc = "debug UI: widgets" })
  vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    dap.ui.widgets.preview()
  end, { desc = "debug UI: widgets" })
  vim.keymap.set('n', '<Leader>df', function()
    dap.ui.widgets.centered_float(dap.ui.widgets.frames)
  end, { desc = "debug UI: widgets" })
  vim.keymap.set('n', '<Leader>ds', function()
    dap.ui.widgets.centered_float(dap.ui.widgets.scopes)
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
      output_mode = "remote",
    },
  })

  local vscode = require('dap.ext.vscode')
  vscode.json_decode = require('json5').parse

  local function load_configs(path)
    local ok, configs = pcall(vscode.getconfigs, path)
    if not ok then return nil end
    for _, cfg in ipairs(configs) do
      if cfg.request == "launch" then
	cfg.outputMode = cfg.outputMode or "remote"
      end
    end
    return configs
  end

  -- using dap.000.launch.json to present its entry first, since it's alphabetically ordered first other providers.
  dap.providers.configs["dap.launch.json"] = nil
  dap.providers.configs["dap.000.launch.json"] = function()
    return load_configs(vim.fn.getcwd() .. '/.vscode/launch_vim.json')
    or load_configs(vim.fn.getcwd() .. '/.vscode/launch.json')
    or {}
  end

  style()
  ---@diagnostic disable-next-line: missing-fields
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
    ---@diagnostic disable-next-line: missing-fields
    floating = { border = "rounded" },
    -- Set dapui window
    ---@diagnostic disable-next-line: missing-fields
    render = {
      max_type_length = 60,
      max_value_lines = 200,
    },
    -- Only one layout: just the "scopes" (variables) list at the bottom
    --    layouts = {
      --      {
	-- elements = {
	  --   { id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
	  -- },
	  -- size = 15,                -- height in lines (adjust to taste)
	  -- position = "bottom",      -- "left", "right", "top", "bottom"
	  --      },
	  --    },
	})
	listeners(dap, dapui)
	keymaps(dap, dapui)
      end

      return M
