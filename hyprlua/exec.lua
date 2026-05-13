-- exec-once = waybar & hyprpaper & hypridle
-- exec-once = kitty
-- # exec-once = sh -c 'XAPP_FORCE_GTKWINDOW_ICON="call-start" firefox --class WebApp-WhatsApp6244 --name WebApp-WhatsApp6244 --profile /home/nickg/.local/share/ice/firefox/WhatsApp6244 --no-remote "https://web.whatsapp.com"'

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("kitty")
end)
