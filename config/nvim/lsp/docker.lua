return {
  cmd = { 'docker-language-server', "start", "--stdio" },
  filetypes = { "dockerfile" },
  settings = {
	docker = {
	  languageserver = {
		formatter = {
		  ignoreMultilineInstructions = true,
		},
	  },
	}
  }
}
