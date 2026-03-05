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
      acp = {
	claude_code = function()
	  return require("codecompanion.adapters").extend("claude_code", {
	    env = {
	      CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE"
	    }
	  })
	end,
      }
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
    },
    rules = {},
  }
}

M.copilot = {
  config = function()
    require('copilot').setup({
      suggestion = {
	enabled = true,
	auto_trigger = false,
	accept = false,
      },
      panel = {
	enabled = false,
      },
      filetypes = {
	["*"] = true,
      },
    })

    vim.keymap.set("i", "<C-a>", function()
      -- ask copilot to generate a suggestion for the current line
      require("copilot.suggestion").next()
    end, { silent = true })

    vim.keymap.set("i", "<C-S-a>", function()
      require("copilot.suggestion").prev()
    end, { silent = true })

    vim.keymap.set("i", "<C-y>", function()
      if require("copilot.suggestion").is_visible() then
	require("copilot.suggestion").accept()
      else
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-y", true, false, true), "n", false)
      end
    end, { silent = true })

    vim.keymap.set("i", "<C-n>", function()
      if require("copilot.suggestion").is_visible() then
	require("copilot.suggestion").dismiss()
      else
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
      end
    end, { silent = true })
  end
}

return M
