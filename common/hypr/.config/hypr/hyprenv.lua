-- # This file contains important, device specific env variables

-- # Telling hyprland to only use iGPU on laptops
-- env = AQ_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1
hl.env("AQ_DRM_DEVICES", "/dev/dri/card2:/dev/dri/card1")

-- Scale GTK/XWayland apps for 4K monitor (pairs with xwayland.force_zero_scaling = true)
hl.env("GDK_SCALE", "2")
-- Bigger cursor for XWayland apps on 4K (HYPRCURSOR_SIZE stays at 24 — Hyprland scales it itself)
hl.env("XCURSOR_SIZE", "24")
-- Prefer Wayland backends
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
