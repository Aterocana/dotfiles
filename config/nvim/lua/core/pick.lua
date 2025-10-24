local M = {}
local pick = require('mini.pick')

M.live_grep = function()
  if vim.fn.isdirectory('.git') == 1 then
    M.live_grep_git()
  else
    require('mini.pick').builtin.grep_live()
  end

end

-- Helper: live grep only in Git-tracked files
M.live_grep_git = function()
  -- Get tracked files using git ls-files
  local git_files = vim.fn.systemlist('git ls-files')

  if vim.v.shell_error ~= 0 or #git_files == 0 then
    vim.notify('Not a Git repository or no tracked files found.', vim.log.levels.WARN)
    return
  end

  -- Run live grep, but restrict to git-tracked files
  pick.builtin.grep_live({
    files = git_files,
  })
end

-- Make sure mini.pick is loaded
require('mini.pick').setup()

-- Custom picker: list all LSP diagnostics
M.pick_diagnostics = function()
  local diag = vim.diagnostic.get(nil, { severity = { min = vim.diagnostic.severity.HINT } })

  if #diag == 0 then
    vim.notify('No diagnostics found', vim.log.levels.INFO)
    return
  end

  -- Convert diagnostics into items understood by mini.pick
  local items = vim.tbl_map(function(d)
    local name = vim.api.nvim_buf_get_name(d.bufnr)
    local rel = vim.fn.fnamemodify(name, ':.')
    local msg = d.message:gsub('\n', ' ')
    local text = string.format('%s:%d:%d  %s  [%s]',
      rel, d.lnum + 1, d.col + 1, msg, vim.diagnostic.severity[d.severity])
    return {
      text = text,
      buf_id = d.bufnr,
      lnum = d.lnum + 1,
      col = d.col + 1,
    }
  end, diag)

  -- Launch the picker
  pick.start({
    source = {
      items = items,
      name = 'Diagnostics',
    },
    mappings = {
      -- Jump to the selected diagnostic
      apply = function(item)
        vim.api.nvim_set_current_buf(item.buf_id)
        vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
        vim.cmd('normal! zz')
      end,
    },
  })
end

return M
