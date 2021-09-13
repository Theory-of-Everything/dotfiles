local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("config.keys")

tags = root.tags()

awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = keys.clientkeys,
			buttons = keys.clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = { "DTA", "copyq", "pinentry" },
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin",
				"Sxiv",
				"mpv",
				"feh",
				"Tor Browser",
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
                "pritunl",
			},
			name = { "Event Tester" },
			role = { "AlarmWindow", "ConfigManager", "pop-up" },
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

	{ rule = { instance = "scpd" }, properties = { floating = true } },

	{ rule = { class = "Conky" }, properties = { skip_taskbar = true } },

	{ rule = { class = "brave-browser" }, properties = { screen = 1, tag = "3" } },

	{ rule = { class = "Mail" }, properties = { screen = 2, tag = "6" } },
}
