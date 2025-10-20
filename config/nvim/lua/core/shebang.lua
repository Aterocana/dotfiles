-- Custom 'shebang' command
local function write_initial_line_custom_shebang()
  -- Define template for custom Shebang, customize at will.
  local shebang_template = [[
#!/usr/bin/env bash
# Author: Aterocana
# Description:
# Version:

set -euo pipefail

usage() {
  echo "usage: $0 ..."
}
if [[ "$1" = "--help" \]\] || [[ "$1" = "-h" \]\]; then
	usage
	exit 0
fi]]

  -- Sets the predefined template string array, split separated by an indent.
  vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(shebang_template, "\n"))
end

vim.api.nvim_create_user_command("Shebang", write_initial_line_custom_shebang, {})
