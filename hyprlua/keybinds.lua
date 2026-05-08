-------------------
--- KEYBINDINGS ---
-------------------

local mod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"
local menu = "rofi -show drun"
local browser = "firefox"
local screenshot_dir = os.getenv("HOME") .. "/Pictures/Screenshots"

-- Core
hl.bind(mod .. " + Return", hl.dsp.exec_cmd({ cmd = terminal }))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mod .. " + B", hl.dsp.exec_cmd({ cmd = browser }))
hl.bind(mod .. " + ALT + L", hl.dsp.exec_cmd({ cmd = "hyprlock" }))
hl.bind(mod .. " + E", hl.dsp.exec_cmd({ cmd = fileManager }))
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod .. " + D", hl.dsp.exec_cmd({ cmd = menu }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(mod .. " + I", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + W", hl.dsp.exec_cmd({ cmd = "sh -c ~/.config/hypr/scripts/wallpaperrandomizer.sh" }))
hl.bind(mod .. " + Escape", function()
	hl.dispatch(hl.dsp.exec_cmd({ cmd = "hyprctl reload" }))
	hl.dispatch(hl.dsp.exec_cmd({ cmd = "notify-send 'Hyprland Reloaded'" }))
end)

-- Move focus (vim keys)
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces (arrow keys + vim keys)
hl.bind(mod .. " + CTRL + right", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + CTRL + left", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + CTRL + L", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + CTRL + H", hl.dsp.focus({ workspace = "-1" }))

-- Switch workspaces + move window (loops)
for i = 1, 9 do
	hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Special workspaces
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mod .. " + Z", hl.dsp.workspace.toggle_special("messages"))
hl.bind(mod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:messages" }))

-- Mouse: scroll through workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse: move/resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Logitech G502x
hl.bind(mod .. " + mouse:277", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + mouse:278", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + mouse:279", hl.dsp.workspace.toggle_special("messages"))
hl.bind(mod .. " + mouse:280", hl.dsp.exec_cmd({ cmd = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" }))
hl.bind(mod .. " + mouse:281", hl.dsp.exec_cmd({ cmd = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-" }))
hl.bind(mod .. " + mouse:282", hl.dsp.exec_cmd({ cmd = "notify-send 'button 282'" }))

-- Resize windows
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 30, relative = true }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -30, relative = true }))

-- Media / brightness keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd({ cmd = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" }),
	{ repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd({ cmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" }),
	{ repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd({ cmd = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" }), { locked = true })
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd({ cmd = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" }),
	{ locked = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd({ cmd = "brightnessctl -e4 -n2 set 5%+" }), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd({ cmd = "brightnessctl -e4 -n2 set 5%-" }), { repeating = true })
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd({ cmd = "brightnessctl -d 'asus::kbd_backlight' set 1+" }))
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd({ cmd = "brightnessctl -d 'asus::kbd_backlight' set 1-" }))

-- Playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd({ cmd = "playerctl next" }), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd({ cmd = "playerctl play-pause" }), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd({ cmd = "playerctl play-pause" }), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd({ cmd = "playerctl previous" }), { locked = true })

-- Gestures
hl.gesture({
	fingers = 3,
	direction = "up",
	action = function()
		hl.dispatch(hl.dsp.exec_cmd({ cmd = "pamixer -i 20" }))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "down",
	action = function()
		hl.dispatch(hl.dsp.exec_cmd({ cmd = "pamixer -d 20" }))
	end,
})
hl.gesture({ fingers = 4, direction = "up", action = "special", arg = "messages" })
hl.gesture({ fingers = 4, direction = "down", action = "special", arg = "messages" })
hl.gesture({ fingers = 4, direction = "up", mods = mod, action = "move", arg = "special:messages" })
hl.gesture({ fingers = 4, direction = "down", mods = mod, action = "move", arg = "special:messages" })

-- Screenshots
local date_cmd = "$(date +'%Y-%m-%d_%H-%M-%S')"
hl.bind(
	"CTRL + Print",
	hl.dsp.exec_cmd({
		cmd = "grim " .. screenshot_dir .. "/" .. date_cmd .. ".png && notify-send 'Full Screenshot Saved'",
	})
)
hl.bind("SHIFT + Print", hl.dsp.exec_cmd({ cmd = 'grim -g "$(slurp)" - | wl-copy && notify-send "Region Copied"' }))
hl.bind(
	"CTRL + SHIFT + Print",
	hl.dsp.exec_cmd({
		cmd = 'wayfreeze & PID=$!; sleep .1; grim -g "$(slurp)" '
			.. screenshot_dir
			.. "/"
			.. date_cmd
			.. ".png; kill $PID && notify-send 'Region Saved'",
	})
)
hl.bind(
	"Print",
	hl.dsp.exec_cmd({
		cmd = 'wayfreeze & PID=$!; sleep .1; grim -g "$(slurp)" - | wl-copy && notify-send "Region Copied to clipboard"',
	})
)
