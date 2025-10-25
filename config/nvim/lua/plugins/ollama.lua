-- Custom configuration (defaults shown)
return {
  {
	"olimorris/codecompanion.nvim",
	opts = require("plugins/configs/code_companion").opts,
	dependencies = {
	  "nvim-lua/plenary.nvim",
	},
  },
  {
	'jacob411/Ollama-Copilot',
	enabled = false,
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
  },
}
