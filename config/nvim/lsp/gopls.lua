return {
  cmd = { 'gopls' },
  filetypes = { "go", "gomod", "gowork" },
  root_markers = { "git", "go.mod", "go.work" },
  settings = {
	gopls = {
	  usePlaceholders = false,
	  completeUnimported = true,
	  ["ui.inlayhint.hints"] = {
		compositeLiteralFields = true,
		constantValues = true,
		parameterNames = true,
		rangeVariableTypes = true,
	  },
	  hints = {
		assignVariableTypes = true,
		compositeLiteralFields = true,
		compositeLiteralTypes = true,
		constantValues = true,
		functionTypeParameters = true,
		parameterNames = true,
		rangeVariableTypes = true,
	  },
	  analyses = {
		unusedvariable = true,
		unusedparams = true
	  }
	}
  }
}
