-- remap branch name in a convenient way
local function branch_name_fmt(branch)
  if not branch or branch == "" then
    return ""
  end
  local icons = {
    feature  = "󰊕 ",
    feat     = "󰊕 ",
    bugfix   = "󰨰 ",
    fix      = "󰨰 ",
    hotfix   = "󰨰 ",
    merge    = "󰽜 ",
    refactor = "󰏖 ",
    design   = "󰏖 ",
    test     = "󰙨 ",
    doc      = "󰈙 ",
  }
  local author, branch_type, name
  local first, rest = branch:match("^(%w+)/(.+)$")
  if first then
    if icons[first] then
      -- feat/name style (no author)
      branch_type, name = first, rest
    else
      -- author/type[-_/]name style
      author = first
      branch_type, name = rest:match("^(%w+)[_%-/](.+)$")
    end
  else
    branch_type, name = branch:match("^(%w+)[_%-](.+)$")
  end
  if name then
    branch_type = icons[branch_type] or (branch_type .. " ")
    local suffix = author and " <" .. author .. ">" or ""
    return branch_type .. name .. suffix
  end
  return branch
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
    -- theme = "gruvbox-material",
    theme = "everforest"
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
	'branch',
	icons = "",
	fmt = branch_name_fmt,
      },
      'diff',
      {
	'diagnostics',
	sources = { 'nvim_lsp' },
	sections = { 'error', 'warn', 'info', 'hint' },
	symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰟶 ' },
	colored = true,    -- Displays diagnostics status in color if set to true.
	update_in_insert = false, -- Update diagnostics in insert mode.
	always_visible = false, -- Show diagnostics even if there are none.
      },
    },
    lualine_c = {
      {
	'filename',
	file_status = true, -- Displays file status (readonly status, modified status)
	newfile_status = false, -- Display new file status (new file means no write after created)

	-- path:
	-- 0: Just the filename
	-- 1: Relative path
	-- 2: Absolute path
	-- 3: Absolute path, with tilde as the home directory
	-- 4: Filename and parent dir, with tilde as the home directory
	path = 1,

	shorting_target = 20, -- Shortens path to leave 40 spaces in the window
	-- for other components. (terrible name, any suggestions?)
	symbols = {
	  modified = '[+]', -- Text to show when the file is modified.
	  readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
	  unnamed = '[No Name]', -- Text to show for unnamed buffers.
	  newfile = '[New]', -- Text to show for newly created file before first write
	}
      },
    },
    lualine_x = {
      "lsp_status",
      {
	function()
	  return require("codecompanion").statusline()
	end,
	cond = function()
	  return package.loaded["codecompanion"] ~= nil
	end,
      },
    },

    lualine_y = {
      {
	-- require("yaml_nvim").get_yaml_key_and_value ,
	require("noice").api.statusline.mode.get,
	cond = require("noice").api.statusline.mode.has,
	color = { fg = "#98971a" },
      }

    },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    -- lualine_y = {'location'},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
