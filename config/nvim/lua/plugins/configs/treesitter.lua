local M = {}

M.config = function ()
  local ts = require('nvim-treesitter')

  ts.install({
	"go", "gomod", "gowork", "gosum", "gotmpl",
	"make",
	"comment",
	"proto",
	"dockerfile",
	"c",
	"bash",
	"javascript",
	"json",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"gitignore",
	"gitcommit",
	"toml",
	"yaml",
	"markdown",
	"markdown_inline",
	"mermaid",
	"regex"
  })
  -- ufo setup
  vim.o.foldcolumn = '0' -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  vim.o.foldmethod = "expr"

  ---@diagnostic disable-next-line: missing-fields
  require('ufo').setup({
	provider_selector = function(bufnr, filetype, buftype)
	  return {'treesitter', 'indent'}
	end
  })
end

M.modules = function ()
  local modules = require('treesitter-modules')

  modules.setup({
	highlight = {
	  enable = true,
	  disable = function(lang, buf)
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
		  return true
		end
	  end,
	  additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
	  enable = true,
	  keymaps = {
		init_selection = "<leader>ss",
		node_incremental = "<leader>si",
		scope_incremental = "<leader>sc",
		node_decremental = "<leader>sd",
	  }
	},
	textobjects = {
	  select = {
		enable = true,
		lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
		keymaps = {
		  -- You can use the capture groups defined in textobjects.scm
		  ['aa'] = '@parameter.outer',
		  ['ia'] = '@parameter.inner',
		  ['af'] = '@function.outer',
		  ['if'] = '@function.inner',
		  ['ac'] = '@class.outer',
		  ['ic'] = '@class.inner',
		  ["iB"] = "@block.inner",
		  ["aB"] = "@block.outer",
		},
	  },
	  selection_modes = {
		['@parameter.outer'] = 'v', -- charwise
		['@function.outer'] = 'V', -- linewise
		--['@function.outer'] = '<c-v>', -- blockwise
		['@class.outer'] = '<c-v>', -- blockwise
	  },
	  move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		goto_next_start = {
		  [']]'] = '@function.outer',
		},
		goto_next_end = {
		  [']['] = '@function.outer',
		},
		goto_previous_start = {
		  ['[['] = '@function.outer',
		},
		goto_previous_end = {
		  ['[]'] = '@function.outer',
		},
	  },
	  swap = {
		enable = true,
		swap_next = {
		  ['<leader>sn'] = '@parameter.inner',
		},
		swap_previous = {
		  ['<leader>sp'] = '@parameter.inner',
		},
	  },
	},
})
end

return M
