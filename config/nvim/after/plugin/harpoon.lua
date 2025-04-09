local harpoon = require("harpoon")
harpoon:setup()

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
	table.insert(file_paths, item.value)
  end

  local make_finder = function()
	local paths = {}

	for _, item in ipairs(harpoon_files.items) do
	  table.insert(paths, item.value)
	end

	return require("telescope.finders").new_table({
	  results = paths,
	})
  end

  require("telescope.pickers").new({}, {
	prompt_title = "Harpoon",
	finder = require("telescope.finders").new_table({
	  results = file_paths,
	}),
	previewer = conf.file_previewer({}),
	sorter = conf.generic_sorter({}),
	attach_mappings = function(prompt_buffer_number, map)
	  -- The keymap you need
	  map("i", "<c-d>", function()
		local state = require("telescope.actions.state")
		local selected_entry = state.get_selected_entry()
		local current_picker = state.get_current_picker(prompt_buffer_number)

		-- This is the line you need to remove the entry
		harpoon:list():remove(selected_entry)
		current_picker:refresh(make_finder())
	  end)

	  return true
	end,
  }):find()
end

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[A]dd current buffer to [H]arpoon"})
vim.keymap.set("n", "<leader>hm", function() toggle_telescope(harpoon:list()) end, { desc = "[H]arpoon [M]enu"})
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, {desc = "[P]revious [H]arpoon buffer"})
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, {desc = "[N]ext [H]arpoon buffer"})
vim.keymap.set("n", "<leader>h1", function () harpoon:list():select(1) end, {desc = "[H]arpoon buffer [1]"})
vim.keymap.set("n", "<leader>h2", function () harpoon:list():select(2) end, {desc = "[H]arpoon buffer [2]"})
vim.keymap.set("n", "<leader>h3", function () harpoon:list():select(3) end, {desc = "[H]arpoon buffer [3]"})
vim.keymap.set("n", "<leader>h4", function () harpoon:list():select(4) end, {desc = "[H]arpoon buffer [4]"})
vim.keymap.set("n", "<leader>h5", function () harpoon:list():select(5) end, {desc = "[H]arpoon buffer [5]"})
vim.keymap.set("n", "<leader>h6", function () harpoon:list():select(6) end, {desc = "[H]arpoon buffer [6]"})
vim.keymap.set("n", "<leader>h7", function () harpoon:list():select(7) end, {desc = "[H]arpoon buffer [7]"})
vim.keymap.set("n", "<leader>h8", function () harpoon:list():select(8) end, {desc = "[H]arpoon buffer [8]"})
vim.keymap.set("n", "<leader>h9", function () harpoon:list():select(9) end, {desc = "[H]arpoon buffer [9]"})
