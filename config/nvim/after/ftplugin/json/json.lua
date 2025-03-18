vim.keymap.set("n", "<SPACE>jb", "<CMD>%!jq .<CR>", {desc = "[J]SON [B]eatify the file"})
vim.keymap.set("n", "<SPACE>jug", "<CMD>%!jq -c .<CR>",{desc = "[J]SON [UG]lify (minify) the file"})
vim.keymap.set("n", "<SPACE>jesc", "<CMD>%!jq -c .<CR><CMD>%!jq -R .<CR>", {desc = "[J]SON [ES]scape the file (it first minifies it)"})
vim.keymap.set("n", "<SPACE>jun", "<CMD>%!jq -r .<CR>", {desc = "[J]SON [UN]escape the file"})
