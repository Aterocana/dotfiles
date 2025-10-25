local M = {}

M.opts = {
  strategies = {
	-- Change the default chat adapter
	chat = { adapter = 'codellama' },
	inline = { adapter = 'codellama' },
	cmd = { adapter = 'codellama' },
  },
  adapters = {
	http = {
	  codellama = function()
		return require('codecompanion.adapters').extend('ollama', {
		  name = 'codellama', -- Give this adapter a different name to differentiate it from the default ollama adapter
		  schema = {
			model = {
			  default = 'codellama:13b',
			},
		  },
		})
	  end,
	  qwen = function()
		return require('codecompanion.adapters').extend('ollama', {
		  name = 'qwen', -- Give this adapter a different name to differentiate it from the default ollama adapter
		  schema = {
			model = {
			  default = 'qwen2.5-coder:14b',
			},
		  },
		})
	  end,
	},
  },
  opts = {
	log_level = 'DEBUG',
  },
  display = {
	diff = {
	  enabled = true,
	  close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
	  layout = 'vertical', -- vertical|horizontal split for default provider
	  opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
	  provider = 'default', -- default|mini_diff
	},
  },
}

return M
