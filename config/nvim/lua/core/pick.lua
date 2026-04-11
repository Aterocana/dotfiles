local M = {}
local pick = require('mini.pick')

M.live_grep = function()
  if vim.fn.isdirectory('.git') == 1 then
    M.live_grep_git()
  else
    require('mini.pick').builtin.grep_live({}, { tool_opts = { '--smart-case' } })
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
  }, { tool_opts = { '--smart-case' } })
end

-- Custom picker: list all LSP diagnostics
M.pick_diagnostics = function()
  local diag = vim.diagnostic.get(nil, { severity = { min = vim.diagnostic.severity.HINT } })

  if #diag == 0 then
    vim.notify('No diagnostics found', vim.log.levels.INFO)
    return
  end

  local items = vim.tbl_map(function(d)
    local name = vim.api.nvim_buf_get_name(d.bufnr)
    local rel = vim.fn.fnamemodify(name, ':.')
    local msg = d.message:gsub('\n', ' ')
    local text = string.format('%s:%d:%d  %s  [%s]',
    rel, d.lnum + 1, d.col + 1, msg, vim.diagnostic.severity[d.severity]
  )

  return {
    text = text,
    buf_id = d.bufnr,
    lnum = d.lnum + 1,
    col = d.col + 1,
  }
end, diag)

-- Highlight for preview
vim.api.nvim_set_hl(0, "MiniPickPreviewDiag", { link = "Visual" })

pick.start({
  source = { items = items, name = 'Diagnostics' },

  -- Standard navigation
  mappings = {
    move_down = '<C-j>',
    move_up = '<C-k>',
  },

  -- Custom actions
  actions = {
    {
      char = '<CR>',
      func = function(item)
        vim.api.nvim_set_current_buf(item.buf_id)
        vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
        vim.cmd('normal! zz')
      end,
    },
  },

  preview = {
    setup = function(item, ctx)
      if not item then return end
      local win = ctx.preview_win
      local buf = item.buf_id

      vim.api.nvim_win_set_buf(win, buf)
      vim.api.nvim_win_set_cursor(win, { item.lnum, item.col - 1 })
      vim.cmd(string.format("normal! %dz", item.lnum))

      -- Clear old highlights
      vim.api.nvim_buf_clear_namespace(buf, ctx.preview_ns, 0, -1)

      -- Highlight the diagnostic line
      vim.api.nvim_buf_set_extmark(buf, ctx.preview_ns, item.lnum - 1, 0, {
        end_row = item.lnum,
        hl_group = "MiniPickPreviewDiag",
        hl_eol = true,
      })
    end,
  },
})
end



local function make_filter(patterns)
  return function(path)
    for _, pattern in ipairs(patterns) do
      if path:match(pattern) then
        return false
      end
    end
    return true
  end
end

local project_filters = {
  {
    check = function(root) return vim.fn.filereadable(root .. '/go.mod') == 1 end,
    patterns = { '/vendor/', '^vendor/' }
  },
  {
    check = function(root) return vim.fn.filereadable(root .. '/package.json') == 1 end,
    patterns = { '/node_modules/', '^node_modules/' }
  },
}

M.pick_files_filters = function(extra_patterns, cwd)
  return function()
    local root = cwd or vim.uv.cwd()
    local active_patterns = vim.deepcopy(extra_patterns or {})
    for _, pf in ipairs(project_filters) do
      if pf.check(root) then
        vim.list_extend(active_patterns, pf.patterns)
      end
    end
    local filter = make_filter(active_patterns)

    local cmd
    if vim.fn.executable('fd') == 1 then
      cmd = 'fd --type f --hidden --exclude .git . ' .. vim.fn.shellescape(root)
    else
      cmd = 'find ' .. vim.fn.shellescape(root) .. ' -type f -not -path "*/.git/*"'
    end

    local all_files = vim.fn.systemlist(cmd)
    local filtered = {}
    for _, f in ipairs(all_files) do
      local rel = f:gsub('^' .. vim.pesc(root) .. '/?', '')
      if filter(rel) then
        table.insert(filtered, rel)
      end
    end

    pick.start({
      source = {
        items = filtered,
        name = 'Files',
        cwd = root,
      },
    })
  end
end

M.pick_keymappings = function()
  -- Get all key mappings in the current buffer
  local keymaps = vim.api.nvim_get_keymap("n")
  -- Convert mappings into items understood by mini.pick
  local items = vim.tbl_map(function(mapping)
    return {
      text = mapping.lhs .. " maps to " .. mapping.rhs,
      buf_id = 0,
      lnum = 1,
      col = 1,
    }
  end, keymaps)

  -- Launch the picker
  pick.start({
    source = {
      items = items,
      name = 'Keymappings',
    },
    mappings = {
      apply = function(item)
        -- Nothing to do here
      end,
    },
  })
end

M.custom = function()
  pick.start({
    source = {
      items = {
        { text = "Option 1" },
        { text = "Option 2" },
        { text = "Option 3" },
      },
      name = 'Custom Options',
    },
  })
end

return M
