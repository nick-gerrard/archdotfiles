------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

-- Steam & Launcher Rules
hl.window_rule({ match = { class = "launcher" }, float = true, no_anim = true, size = "1000 750", center = true })
hl.window_rule({ match = { title = "Sharing" }, float = true })

-- Steam Grouped Rules
hl.window_rule({ match = { class = "Steam|steam|steamwebhelper" }, float = true, no_shadow = true, no_blur = true })

-- Gamescope & Steam Apps
hl.window_rule({ match = { class = "gamescope" }, idle_inhibit = "always" })
hl.window_rule({
	match = { class = "steam_app_.*" },
	fullscreen = true,
	render_unfocused = true,
	immediate = true,
	idle_inhibit = "always",
	allows_input = true,
})

-- Fullscreen state matchers
hl.window_rule({ match = { fullscreen = true }, immediate = true, idle_inhibit = "always" })

-- Layer Rules
hl.layer_rule({ match = { namespace = "wayfreeze" }, no_anim = true })

-- Global Fixes
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- XWayland Fix
hl.window_rule({
	match = { class = "", title = "", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

-- Network & Audio
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true, size = "50% 50%", center = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true, size = "50% 50%", center = true })
hl.window_rule({ match = { class = "firefox", title = "File Upload" }, float = true, center = true })
hl.window_rule({ match = { class = "google-chrome-stable", title = "File Upload" }, float = true, center = true })

-- Special Workspace: WhatsApp
hl.window_rule({
	match = { class = "WebApp-WhatsApp%d+" },
	workspace = "special:messages",
	float = true,
	no_initial_focus = true,
	size = "70% 80%",
	center = true,
})

-- Special Workspace: Magic
hl.window_rule({ match = { class = "signal" }, workspace = "special:magic", tile = true })
hl.window_rule({ match = { class = "discord" }, workspace = "special:magic", tile = true })

-- Workspace Definitions
hl.workspace_rule({ workspace = "special:messages" })
hl.workspace_rule({ workspace = "1", monitor = "DP-3"})
hl.workspace_rule({ workspace = "2", monitor = "DP-3"})
hl.workspace_rule({ workspace = "3", monitor = "DP-3"})
hl.workspace_rule({ workspace = "4", monitor = "DP-3"})
hl.workspace_rule({ workspace = "5", monitor = "DP-3"})
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1"})

