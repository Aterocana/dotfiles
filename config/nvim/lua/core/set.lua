vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line

vim.opt.wrap = true
vim.opt.wrapmargin=1
vim.opt.textwidth=0

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  lead = '·',
  trail = '•',
  nbsp = "␣",
  eol = "↲",
  extends="⟩",
  precedes="⟨"
}
vim.g.have_nerd_font = true
vim.opt.cursorline = true
vim.opt.conceallevel = 1
