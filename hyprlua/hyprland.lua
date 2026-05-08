-- hyprland.lua

-- Source all other config files
require("exec")
require("keybinds")
require("monitors")
require("windows")
require("hyprenv")

-- Environment variables
hl.env("GTK_THEME", "Adwaita-dark")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Main settings
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col_active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg",
		col_inactive_border = "rgba(595959aa)",
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 4,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
		bezier = {
			{ name = "easeOutQuint", x0 = 0.23, y0 = 1, x1 = 0.32, y1 = 1 },
			{ name = "easeInOutCubic", x0 = 0.65, y0 = 0.05, x1 = 0.36, y1 = 1 },
			{ name = "linear", x0 = 0, y0 = 0, x1 = 1, y1 = 1 },
			{ name = "almostLinear", x0 = 0.5, y0 = 0.5, x1 = 0.75, y1 = 1 },
			{ name = "quick", x0 = 0.15, y0 = 0, x1 = 0.1, y1 = 1 },
		},
		animation = {
			{ name = "global", enabled = true, speed = 10, curve = "default" },
			{ name = "border", enabled = true, speed = 5.39, curve = "easeOutQuint" },
			{ name = "windows", enabled = true, speed = 4.79, curve = "easeOutQuint" },
			{ name = "windowsIn", enabled = true, speed = 4.1, curve = "easeOutQuint", style = "slide 87%" },
			{ name = "windowsOut", enabled = true, speed = 1.49, curve = "linear", style = "popin 87%" },
			{ name = "fadeIn", enabled = true, speed = 1.73, curve = "almostLinear" },
			{ name = "fadeOut", enabled = true, speed = 1.46, curve = "almostLinear" },
			{ name = "fade", enabled = true, speed = 3.03, curve = "quick" },
			{ name = "layers", enabled = true, speed = 3.81, curve = "easeOutQuint" },
			{ name = "layersIn", enabled = true, speed = 4, curve = "easeOutQuint", style = "fade" },
			{ name = "layersOut", enabled = true, speed = 1.5, curve = "linear", style = "fade" },
			{ name = "fadeLayersIn", enabled = true, speed = 1.79, curve = "almostLinear" },
			{ name = "fadeLayersOut", enabled = true, speed = 1.39, curve = "almostLinear" },
			{ name = "workspaces", enabled = true, speed = 1.94, curve = "almostLinear", style = "slide" },
			{ name = "workspacesIn", enabled = true, speed = 1.21, curve = "almostLinear" },
			{ name = "workspacesOut", enabled = true, speed = 1.94, curve = "almostLinear" },
			{ name = "zoomFactor", enabled = true, speed = 7, curve = "quick" },
		},
	},

	dwindle = {
		pseudotile = true,
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = true,
		},
	},

	xwayland = {
		force_zero_scaling = true,
	},
})

-- Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Per-device config
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
