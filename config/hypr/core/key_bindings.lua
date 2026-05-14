local vars = require("core.variables")

local mainMod = vars.main_mod
local shiftMainMod = vars.shift_main_mod
local altMainMod = vars.alt_main_mod

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("~/.config/rofi/scripts/tmux_sessions.sh"))
hl.bind(shiftMainMod .. " + Return", hl.dsp.exec_cmd(vars.terminal))
hl.bind(shiftMainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(vars.menu))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/rofi/scripts/window_switch.sh"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(shiftMainMod .. " + X", hl.dsp.exec_cmd("~/.config/rofi/scripts/powermenu.sh"))
hl.bind(shiftMainMod .. " + B", hl.dsp.exec_cmd("google-chrome-stable --profile-directory=Default"))
hl.bind(shiftMainMod .. " + W", hl.dsp.exec_cmd("wayscriber -a"))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(shiftMainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))

hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("~/.config/rofi/scripts/clipboard.sh pick"))
hl.bind(altMainMod .. " + C", hl.dsp.exec_cmd("~/.config/rofi/scripts/clipboard.sh clear"))

hl.bind("Print", hl.dsp.exec_cmd("~/.config/rofi/scripts/screenshot.sh"))
hl.bind(shiftMainMod .. " + Print", hl.dsp.exec_cmd("~/.config/rofi/scripts/screenshot.sh window"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.config/rofi/scripts/screenshot.sh area"))
hl.bind(shiftMainMod .. " + T", hl.dsp.exec_cmd("~/.config/rofi/scripts/screenshot.sh transcribe"))

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("rofi -show ssh"))
hl.bind(shiftMainMod .. " + Space", hl.dsp.exec_cmd("swaync-client -C"))
hl.bind(shiftMainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(shiftMainMod .. " + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(shiftMainMod .. " + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(shiftMainMod .. " + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(shiftMainMod .. " + J", hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + ALT + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(
  mainMod .. " + mouse_down",
  hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')")
)
hl.bind(
  mainMod .. " + mouse_up",
  hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')")
)

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("~/bin/hacli media_player media_player.studio play_pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("~/bin/hacli media_player media_player.studio previous_track"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("~/bin/hacli media_player media_player.studio next_track"), { locked = true })
