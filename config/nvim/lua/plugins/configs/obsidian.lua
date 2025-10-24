local M = {
  opts = {
	workspaces = {
	  {
		name = "personal",
		path = "~/Nextcloud/Documents/obsidian/appunti",
	  },
	},
	completion = {
	  -- Set to false to disable completion.
	  nvim_cmp = true,
	  -- Trigger completion at 2 chars.
	  min_chars = 2,
	},
	picker = {
	  -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
	  name = "mini.pick",
	  -- Optional, configure key mappings for the picker. These are the defaults.
	  -- Not all pickers support all mappings.
	  note_mappings = {
		-- Create a new note from your query.
		new = "<C-x>",
		-- Insert a link to the selected note.
		insert_link = "<C-l>",
	  },
	  tag_mappings = {
		-- Add tag(s) to current note.
		tag_note = "<C-x>",
		-- Insert a tag at the current location.
		insert_tag = "<C-l>",
	  },
	},

  }
}
return M
