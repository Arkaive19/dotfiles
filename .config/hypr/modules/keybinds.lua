-- ~/.config/hypr/modules/keybinds.lua
---@module 'hl'

local mainMod = "SUPER"

--#######################
--## APPLICATIONS
--#######################
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("rofi -show filebrowser -theme ~/.config/rofi/layout.rasi"))

--#######################
--## WINDOW MANAGEMENT
--#######################
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("kill -9 $(hyprctl activewindow -j | jq -r '.pid')"))
hl.bind(
	mainMod .. " + SHIFT + X",
	hl.dsp.exec_cmd(
		"ws=$(hyprctl activewindow -j | jq -r '.workspace'); hyprctl clients -j | jq -r --argjson ws \"$ws\" '.[] | select(.workspace==$ws) | .pid' | xargs -r kill -9"
	)
)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

--#######################
--## SYSTEM
--#######################
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_layout.sh"))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("wlogout -C /home/arkaive19/.config/wlogout/nova.css"))

--#######################
--## EWW / UI CONTROLS
--#######################
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("eww open csheet --toggle"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("eww open loadout --toggle"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("pkill eww && eww daemon &"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_bar.sh"))

--#######################
--## SCRIPTS
--#######################
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("~/.config/Wallpapers/Scripts/themeChanger.sh"))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.exec_cmd("~/.config/Wallpapers/Scripts/themeChangerLive.sh"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/hypr/scripts/game-mode.sh"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("~/.config/hypr/scripts/change_lang.sh"))

--#######################
--## MONITOR CONTROLS
--#######################
hl.bind(mainMod .. " + ALT + LEFT", hl.dsp.exec_cmd("~/.config/hypr/scripts/rotate-all-monitors.sh left"))
hl.bind(mainMod .. " + ALT + RIGHT", hl.dsp.exec_cmd("~/.config/hypr/scripts/rotate-all-monitors.sh right"))

--#######################
--## SCREENSHOTS / RECORDING
--#######################
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
hl.bind("PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/capture-noanim.sh ss"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/capture-noanim.sh vid"))

--#######################
--## CLIPBOARD
--#######################
hl.bind(
	mainMod .. " + B",
	hl.dsp.exec_cmd("cliphist list | rofi -dmenu -theme ~/.config/rofi/clipboard.rasi | cliphist decode | wl-copy")
)
hl.bind(
	mainMod .. " + SHIFT + B",
	hl.dsp.exec_cmd('cliphist wipe && wl-copy --clear && notify-send "Clipboard Cleared!" "Clipboard history cleared."')
)

--#######################
--## INPUT UTILITIES
--#######################
hl.bind(
	mainMod .. " + K",
	hl.dsp.exec_cmd('bash -c "[ $(pidof wvkbd-deskintl) ] && pkill wvkbd-deskintl || wvkbd-deskintl"')
)
hl.bind("ALT + E", hl.dsp.exec_cmd("/home/arkaive19/.config/hypr/scripts/Flemozi-linux-x86_64.AppImage"))

--#######################
--## WINDOW NAVIGATION
--#######################
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

--#######################
--## WORKSPACES
--#######################
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

--#######################
--## SPECIAL WORKSPACE
--#######################
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + A", hl.dsp.workspace.toggle_special("work"))
hl.bind(mainMod .. " + D", hl.dsp.workspace.toggle_special("music"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "special:work" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.move({ workspace = "special:music" }))

--#######################
--## WORKSPACE SCROLL
--#######################
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

--#######################
--## MOUSE WINDOW CONTROL
--#######################
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--#######################
--## EXPO / MEDIA KEYS
--#######################
hl.bind("ALT + Tab", hl.dsp.exec_cmd("pkill -SIGUSR1 hyprexpose"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
