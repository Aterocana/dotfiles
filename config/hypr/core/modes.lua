local vars = require("core.variables")
local resizeGap = 50

hl.bind(vars.main_mod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
  hl.bind("h", hl.dsp.window.resize({ x = -resizeGap, y = 0, relative = true }), { repeating = true })
  hl.bind("j", hl.dsp.window.resize({ x = 0, y = resizeGap, relative = true }), { repeating = true })
  hl.bind("k", hl.dsp.window.resize({ x = 0, y = -resizeGap, relative = true }), { repeating = true })
  hl.bind("l", hl.dsp.window.resize({ x = resizeGap, y = 0, relative = true }), { repeating = true })

  hl.bind("escape", hl.dsp.submap("reset"))
end)
