local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Ayu Mirage"
config.window_background_opacity = 0.92
config.font = wezterm.font("ZedMono Nerd Font")
config.font_size = 16.0
config.scrollback_lines = 100000
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}
config.macos_window_background_blur = 20
config.window_frame = {
	font = wezterm.font({ family = "ZedMono Nerd Font", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 13.0,
}

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x1bOH" }),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x1bOF" }),
	},
}
-- config.macos_force_enable_shadow = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

return config
