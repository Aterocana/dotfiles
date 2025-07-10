-- Custom configuration (defaults shown)
return {
  'jacob411/Ollama-Copilot',
  opts = {
	model_name = "starcoder2:15b",
	ollama_url = "http://localhost:11434", -- URL for Ollama server, Leave blank to use default local instance.
	stream_suggestion = false,
	python_command = "python3",
	filetypes = {'python', 'lua','vim', "markdown", "golang"},
	ollama_model_opts = {
	  num_predict = 40,
	  temperature = 0.1,
	},
	keymaps = {
	  suggestion = '<leader>os',
	  reject = '<leader>or',
	  insert_accept = '<Tab>',
	},
  }
}
