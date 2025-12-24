local M = {}

M.code_companion = {
  opts = {
    log_level = 'DEBUG',
    interactions = {
      -- Change the default chat adapter
      -- chat = { adapter = 'codellama' },
      -- inline = { adapter = 'codellama' },
      -- cmd = { adapter = 'codellama' },
      chat = { adapter = 'copilot' },
      inline = {
	keymaps = {
	  accept_change = {
	    modes = { n = "gda" }, -- Remember this as DiffAccept
	  },
	  reject_change = {
	    modes = { n = "gdr" }, -- Remember this as DiffReject
	  },
	},
	adapter = 'copilot',
      },
      cmd = { adapter = 'copilot' },
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
    display = {
      diff = {
	enabled = true,
	close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
	layout = 'vertical', -- vertical|horizontal split for default provider
	opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
	provider = 'default', -- default|mini_diff
      },
    },
    prompt_library = {
      markdown = {
	dirs = {
	  vim.fn.getcwd() .. "../../../prompts",
	}
      }
    }
  }
}

M.copilot = {
  config = function()
    require('copilot').setup({
      nes = {
	enabled = false, -- requires copilot-lsp as a dependency
	auto_trigger = true,
	keymap = {
	  accept_and_goto = false,
	  accept = false,
	  dismiss = false,
	},
      }
    })
  end
}

return M
