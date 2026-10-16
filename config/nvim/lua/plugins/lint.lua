local sql_filetypes = {
  sql = true,
  mysql = true,
  plsql = true,
  pgsql = true,
}

return {
  {
    "mfussenegger/nvim-lint",
    ft = { "sql", "mysql", "plsql", "pgsql" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
        sql = { "sqlfluff" },
        mysql = { "sqlfluff" },
        plsql = { "sqlfluff" },
        pgsql = { "sqlfluff" },
      })

      local missing_sqlfluff_notified = false

      local function try_sqlfluff()
        if not sql_filetypes[vim.bo.filetype] then
          return
        end

        if vim.fn.executable("sqlfluff") == 0 then
          if not missing_sqlfluff_notified then
            missing_sqlfluff_notified = true
            vim.notify("sqlfluff not found; install it to enable SQL linting", vim.log.levels.WARN)
          end
          return
        end

        lint.try_lint()
      end

      vim.api.nvim_create_autocmd({ "FileType", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("SqlfluffLint", { clear = true }),
        callback = try_sqlfluff,
      })

      try_sqlfluff()
    end,
  },
}
