vim.keymap.set("n", "<SPACE>jb", "<CMD>%!jq .<CR>")
vim.keymap.set("n", "<SPACE>jug", "<CMD>%!jq -c .<CR>")
vim.keymap.set("n", "<SPACE>jesc", "<CMD>%!jq -c .<CR><CMD>%!jq -R .<CR>")
vim.keymap.set("n", "<SPACE>jun", "<CMD>%!jq -r .<CR>")
