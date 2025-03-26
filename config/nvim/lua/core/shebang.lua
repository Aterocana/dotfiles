-- Custom 'shebang' command
local function write_initial_line_custom_shebang()
  -- Define template for custom Shebang, customize at will.
  local shebang_template = [[
#!/usr/bin/env bash
# Author: Aterocana
# Description:
# Version:

usage() {
  usage_string = "usage: $ "
}]]

  -- Sets the predefined template string array, split separated by an indent.
  vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(shebang_template, "\n"))
end

vim.api.nvim_create_user_command("Shebang", write_initial_line_custom_shebang, {})
