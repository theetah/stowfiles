local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Font
config.font_size = 12
config.line_height = 1.1
config.font = wezterm.font("BitstromWera Nerd Font", {
	weight = "Regular",
})

-- Colorscheme

config.color_scheme = "Decaf (base16)"

-- Window Appearance
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Tabs

config.hide_tab_bar_if_only_one_tab = true
-- Would enable this, if it also focused the window when it happened
-- config.prefer_to_spawn_tabs = true

-- Keybinds

config.keys = {
	{ key = "Backspace", mods = "CTRL", action = act({ SendString = "\x17" }) }, -- Fix ctrl+backspace keybind in nvim
	{ key = "LeftArrow", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
}

-- Miscellaneous

-- config.max_fps = 120
config.hide_mouse_cursor_when_typing = true
config.cursor_blink_rate = 0

-- Maximize window on startup

-- NOTE: To myself, ensure you have created a KDE window rule to disable titlebar
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	if mux then
		local _, _, window = mux.spawn_window(cmd or {})
		window:gui_window():maximize()
	end
end)
-- NOTE: This will only work if native wayland is disabled, unfortunately
config.enable_wayland = false

return config
