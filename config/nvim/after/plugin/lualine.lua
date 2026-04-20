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

-- a list of open buffers
local _buf_list = {}

-- it closes the buffer with provided index.
local function close_buf(idx)
  local buf = _buf_list[idx]
  if not buf then return end
  local wins = vim.fn.win_findbuf(buf)
  for _, win in ipairs(wins) do
    local next = vim.fn.bufnr("#") ~= buf and vim.fn.bufnr("#") or -1
    if next == -1 then
      for _, b in ipairs(vim.api.nvim_list_bufs()) do
	if b ~= buf and vim.bo[b].buflisted then
	  next = b; break
	end
      end
    end
    if next ~= -1 then vim.api.nvim_win_set_buf(win, next) end
  end
  vim.api.nvim_buf_delete(buf, { force = false })
end

function LualineBufClick(id, _clicks, button, _mods)
  local buf = _buf_list[id]
  if not buf then return end
  if button == "l" then
    vim.api.nvim_set_current_buf(buf)
  elseif button == "m" then
    close_buf(id)
  end
end

-- add alternate colors to open buffers names, highlighting current selected one.
local function setup_buf_hl()
  local b = vim.api.nvim_get_hl(0, { name = "lualine_b_normal", link = false })
  local c = vim.api.nvim_get_hl(0, { name = "lualine_c_normal", link = false })
  local a = vim.api.nvim_get_hl(0, { name = "lualine_a_normal", link = false })
  vim.api.nvim_set_hl(0, "LualineBufOdd", { fg = b.fg, bg = b.bg })
  vim.api.nvim_set_hl(0, "LualineBufEven", { fg = c.fg, bg = c.bg })
  vim.api.nvim_set_hl(0, "LualineBufActive", { fg = a.fg, bg = a.bg, bold = true })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_buf_hl })

local function open_buffers()
  local all_bufs = vim.tbl_filter(function(b)
    return vim.bo[b].buflisted and vim.api.nvim_buf_is_loaded(b)
  end, vim.api.nvim_list_bufs())

  for k in pairs(_buf_list) do _buf_list[k] = nil end

  local current = vim.api.nvim_get_current_buf()
  local available = vim.o.columns - 4
  local dots_w = vim.fn.strdisplaywidth(" … ")

  -- pre-compute widths (label is always 1 char: 1-9 or 0)
  local items = {}
  local cur_pos = 1
  for i, buf in ipairs(all_bufs) do
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
    if name == "" then name = "[No Name]" end
    local is_active = buf == current
    local w = 3 + vim.fn.strdisplaywidth(name) + (is_active and 2 or 0)
    items[i] = { buf = buf, name = name, is_active = is_active, w = w }
    if is_active then cur_pos = i end
  end

  if #items == 0 then return "" end

  -- slide window right until cur_pos is included
  local win_start = 1
  local win_end = 0

  while win_start <= cur_pos do
    local used = win_start > 1 and dots_w or 0
    win_end = win_start - 1

    for i = win_start, #items do
      local right_dots = i < #items and dots_w or 0
      if used + items[i].w + right_dots <= available then
	used = used + items[i].w
	win_end = i
      else
	break
      end
    end

    if win_end >= cur_pos then break end
    win_start = win_start + 1
  end

  -- fallback: terminal too narrow to fit even cur_pos alone
  if win_end < cur_pos then
    local item = items[cur_pos]
    _buf_list[1] = item.buf
    return "%1@v:lua.LualineBufClick@%#LualineBufActive# 1 [" .. item.name .. "] %T"
  end

  local parts = {}
  if win_start > 1 then
    table.insert(parts, "%#LualineBufOdd# … ")
  end

  for i = win_start, win_end do
    local idx = i - win_start + 1
    local item = items[i]
    _buf_list[idx] = item.buf
    local label = idx == 10 and "0" or tostring(idx)
    local display = " " .. label .. " " .. (item.is_active and "[" .. item.name .. "]" or item.name) .. " "
    local hl = item.is_active and "%#LualineBufActive#"
    or (idx % 2 == 1 and "%#LualineBufOdd#" or "%#LualineBufEven#")
    table.insert(parts, "%" .. idx .. "@v:lua.LualineBufClick@" .. hl .. display .. "%T")
  end

  if win_end < #items then
    table.insert(parts, "%#LualineBufOdd# … ")
  end

  return table.concat(parts, "")
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
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
    lualine_c = { open_buffers },
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

setup_buf_hl()


-- keymaps for switching buffers
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, function()
    local buf = _buf_list[i]
    if buf then vim.api.nvim_set_current_buf(buf) end
  end, { desc = "Go to buffer " .. i })
  vim.keymap.set("n", "<leader>c" .. i, function() close_buf(i) end,
  { desc = "Close buffer " .. i })
end

-- keymaps for closing buffers
vim.keymap.set("n", "<leader>0", function()
  local buf = _buf_list[10]
  if buf then vim.api.nvim_set_current_buf(buf) end
end, { desc = "Go to buffer 10" })
vim.keymap.set("n", "<leader>c0", function() close_buf(10) end,
{ desc = "Close buffer 10" })
