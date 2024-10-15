local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Ayu Mirage"
config.window_background_opacity = 0.95
config.font = wezterm.font("ZedMono Nerd Font")
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

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "rgba(0,0,0,0)",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#333333",
}

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#575757",
	},
}

return config
