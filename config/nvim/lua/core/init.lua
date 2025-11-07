vim.g.mapleader = " "
require("core.remap")                    -- keybindings
require("core.lsp")
require("core.set")                      -- settings
require("core.autocmds") -- auto commands
require("core.shebang")                  -- Shebang command
require("core.search")
require("core.inlay_hints").config({ inlay_hints = true })
require("core.syntax_highlight")
require("core.diagnostic")
require("core.lazy") -- load lazy
