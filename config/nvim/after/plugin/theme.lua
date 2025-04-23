require("noice").setup({
  lsp = {
	-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	override = {
	  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	  ["vim.lsp.util.stylize_markdown"] = true,
	  ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
	},
	hover = {
	  border = { style = "rounded" }
	}
  },
  views = {
	cmdline_popup = {
	  position = {
		row = 5,
		col = "50%",
	  },
	  size = {
		width = 60,
		height = "auto",
	  },
	},
	popupmenu = {
	  relative = "editor",
	  position = {
		row = 8,
		col = "50%",
	  },
	  size = {
		width = 60,
		height = 10,
	  },
	  border = {
		style = "rounded",
		padding = { 0, 1 },
	  },
	  win_options = {
		winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
	  },
	},
  },

  -- you can enable a preset for easier configuration
  presets = {
	bottom_search = true, -- use a classic bottom cmdline for search
	command_palette = true, -- position the cmdline and popupmenu together
	long_message_to_split = true, -- long messages will be sent to a split
	inc_rename = false, -- enables an input dialog for inc-rename.nvim
	lsp_doc_border = true, -- add a border to hover docs and signature help
  },
})

function Theme(theme, darkness)
  theme = theme or "gruvbox"
  darkness = darkness or "dark"
  vim.cmd.colorscheme(theme)
  vim.o.background = darkness
  require("notify").setup({
	background_colour = "#000000",
  })

  -- override style for highlighted text, in order to properly work with illuminate plugin
  vim.cmd('hi IlluminatedWordText guibg=#504945 gui=bold')
end

require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
	strings = true,
	emphasis = true,
	comments = true,
	operators = false,
	folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})
Theme("gruvbox", "dark")
