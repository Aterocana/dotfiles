local M = {
  setup = function()
    require("aerial").setup()
    vim.api.nvim_create_autocmd("User", {
      pattern = "AerialAttach",
      callback = function(args)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = args.buf })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = args.buf })
      end,
    })
    vim.keymap.set("n", "<leader><leader>a", "<CMD>AerialToggle!<CR>")
  end
}

return M
