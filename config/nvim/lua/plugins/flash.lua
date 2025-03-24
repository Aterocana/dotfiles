local flash_opts = require('plugins.configs.flash')
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = flash_opts.opts,
  keys = flash_opts.keys,
}
