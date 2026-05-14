hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 5,
    border_size = 1,

    col = {
      active_border = {
        colors = { "rgb(254,128,25)", "rgb(214,93,14)" },
        angle = 45,
      },
      -- active_border = {
      --   colors = { "rgb(152,151,26)", "rgb(184,187,38)" },
      --   angle = 45,
      -- },
      inactive_border = "rgb(168,153,132)",
    },

    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },
})
