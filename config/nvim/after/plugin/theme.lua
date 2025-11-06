require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
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

  -- set popup menu transparency
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "#282828", blend = 20 })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#98971a", fg = "#282828", blend = 20 })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#282828" })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#98971a" })

  vim.api.nvim_set_hl(0, "CmdlinePmenu", { bg = "#282828", blend = 20 })
  vim.api.nvim_set_hl(0, "CmdlinePmenuSel", { bg ="#98971a", fg = "#282828", blend = 20 })
  vim.api.nvim_set_hl(0, "CmdlinePmenuSbar", { bg = "#282828" })
  vim.api.nvim_set_hl(0, "CmdlinePmenuThumb", { bg ="#98971a"   })

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

local devicons = require 'nvim-web-devicons'
require('incline').setup {
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
    if filename == '' then
      filename = '[No Name]'
    end
    local ft_icon, ft_color = devicons.get_icon_color(filename)

    local function get_git_diff()
      local icons = { removed = ' + ', changed = '  ', added = '  ' }
      local signs = vim.b[props.buf].gitsigns_status_dict
      local labels = {}
      if signs == nil then
	return labels
      end
      for name, icon in pairs(icons) do
	if tonumber(signs[name]) and signs[name] > 0 then
	  table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
	end
      end
      if #labels > 0 then
	table.insert(labels, { '┊ ' })
      end
      return labels
    end

    local function get_diagnostic_label()
      local icons = { error = '', warn = '', info = '', hint = '' }
      local label = {}

      for severity, icon in pairs(icons) do
	local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
	if n > 0 then
	  table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
	end
      end
      if #label > 0 then
	table.insert(label, { '┊ ' })
      end
      return label
    end

    return {
      { get_diagnostic_label() },
      { get_git_diff() },
      { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
      { filename .. ' ', gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
      -- { '┊  ' .. vim.api.nvim_win_get_number(props.win), group = 'DevIconWindows' },
    }
  end,
}
