return {
  {
	"toppair/peek.nvim",
	event = { "VeryLazy" },
	build = "deno task --quiet build:fast",
	config = function()
	  require('peek').setup({
		auto_load = true,         -- whether to automatically load preview when entering another markdown buffer
		close_on_bdelete = true,  -- close preview window on buffer delete
		syntax = true,            -- enable syntax highlighting, affects performance
		theme = 'dark',           -- 'dark' or 'light'
		update_on_change = true,
		app = 'webview',          -- 'webview', 'browser', string or a table of strings
		filetype = { 'markdown' },-- list of filetypes to recognize as markdown
		throttle_at = 200000,     -- start throttling when file exceeds this amount of bytes in size
		throttle_time = 'auto',   -- minimum amount of time in milliseconds that has to pass before starting new render
	  })

	  vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
	  vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	end,
  },
  {
	"epwalsh/obsidian.nvim",
	version = "3.9.0",  -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
	  -- Required.
	  "nvim-lua/plenary.nvim",
	},
	opts = require("plugins.configs.obsidian").opts,
  }
}
