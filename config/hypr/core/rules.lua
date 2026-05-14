hl.window_rule({
  match = { class = "org.gnome.Calculator" },
  float = true,
})

hl.window_rule({
  match = { class = "org.gnome.Calculator" },
  size = { 678, 996 },
})

hl.window_rule({
  match = { class = "thunar" },
  opacity = "0.95",
})

hl.window_rule({
  match = { class = "keymapp" },
  opacity = "0.6",
})

hl.window_rule({
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

hl.window_rule({
  match = { float = false, workspace = "w[tv1]" },
  border_size = 0,
  rounding = 0,
})

hl.window_rule({
  match = { float = false, workspace = "f[1]" },
  border_size = 0,
  rounding = 0,
})

-- hl.config({
--   xwayland = {
--     force_zero_scaling = true,
--   },
-- })

hl.env("GDK_SCALE", "1")
hl.env("XCURSOR_SIZE", "36")
