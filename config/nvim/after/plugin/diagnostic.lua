vim.diagnostic.config({
  virtual_text = {
	current_line = true,
	severity = {
	  max = vim.diagnostic.severity.WARN,
	}
  },
  virtual_lines = {
	severity = {
	  min = vim.diagnostic.severity.ERROR,
	}
  },
})
