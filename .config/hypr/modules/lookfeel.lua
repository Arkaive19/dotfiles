-- ~/.config/hypr/modules/lookfeel.lua
---@module 'hl'

local border_module = require("modules/border")

-- 1. General Config Layout Matrix
hl.config({
	general = {
		gaps_in = 2,
		border_size = 1,
		gaps_out = { top = 11, right = 15, bottom = 11, left = 4 },
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
		col = {
			inactive_border = "rgba(59595900)",
			active_border = border_module.active_border,
		},
	},
})

hl.config({
	decoration = {
		rounding = 20,
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
			size = 8,
			passes = 3,
			new_optimizations = true,
		},
	},
})

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
	},
})

-- 2. Native Global Animation Engine Initialization
hl.config({
	animations = {
		enabled = true,
	},
})

-- Register cubic bezier nodes globally
-- 2. Correct Curve Declaration Structure (X0, Y0, X1, Y1 values)
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("default", { type = "bezier", points = { { 0.12, 0.92 }, { 0.08, 1.0 } } })

-- 3. Correct Animation Target Matrix (CRITICAL: Key MUST be 'bezier')
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })
hl.animation({ leaf = "layers", enabled = true, speed = 7, bezier = "myBezier", style = "slide" })

-- 3. Corrected Layer Rules (Stripped out broken auto-converter strings)
hl.layer_rule({
	match = {
		namespace = "eww-bar",
	},
	animation = "slide left",
})

hl.layer_rule({
	match = {
		namespace = "eww-bar-filler",
	},
	animation = "slide right",
})
