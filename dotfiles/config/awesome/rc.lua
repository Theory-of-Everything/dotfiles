--  __ ___      _____  ___  ___  _ __ ___   _____      ___ __ ___
-- / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ \ /\ / / '_ ` _ \
--| (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/\ V  V /| | | | | |
-- \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___| \_/\_/ |_| |_| |_|
--
--
-- Theory's AwesomeWM Configs
--
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local menubar = require('menubar')
local naughty = require('naughty')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.autofocus')

-- local libraries to require
local keys = require('config.keys')
local bar = require('config.bar')
local themeloader = require('lib.themeloader')
local bling = require('bling')
require('config')
require('misc')

-- {{{ Variable definitions

themeloader.set_global_theme('everforest')
-- themeloader.set_xres_theme('oxide')
-- themeloader.set_awesome_theme('everforest')


-- This is used later as the default terminal and editor to run.
terminal = 'urxvt'
editor = os.getenv('EDITOR') or 'nvim'
editor_cmd = terminal .. ' -e ' .. editor
browser = 'brave'
flieman = 'Thunar'
imageman = 'feh'
videoman = 'mpv'

scriptdir = os.getenv('SCRIPTDIR') or '$HOME/.config/scripts'

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a power menu
powermenu = awful.menu({
	items = {
		{ 'Shut Down', 'systemctl shutdown' },
		{ 'Reboot', 'systemctl reboot' },
		{ 'Lock', 'physlock -s' },
		{ 'Logout', 'awesome quit' },
	},
})

launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = powermenu })

menubar.utils.terminal = terminal
mykeyboardlayout = awful.widget.keyboardlayout()
-- }}}

-- credit to Dark NES#4901
-- local clock = {
-- 	-- widget = {
-- 	--     {
-- 	--         widget = wibox.widget.textbox,
-- 	--     },
-- 	--     widget = wibox.container.rotate,
-- 	-- },
-- 	widget = wibox.widget.textbox,
-- 	align = 'center',
-- 	font = 'cozette 10',
-- }
-- gears.timer({
-- 	autostart = true,
-- 	call_now = true,
-- 	timeout = 60,
-- 	callback = function()
-- 		local t = os.date('*t')
-- 		clock.markup = '<b>'
-- 			.. (t.hour < 10 and '0' .. t.hour or t.hour)
-- 			.. '</b>\n'
-- 			.. (t.min < 10 and '0' .. t.min or t.min)
-- 	end,
-- })

local function set_wallpaper(s)
	-- Wallpaper
	awful.spawn.with_shell('nitrogen --restore')
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal('property::geometry', set_wallpaper)

local fs_wid = require('widget.fs-widget.fs-widget')
local mpd_wid = require('widget.mpdarc-widget.mpdarc')
local gith_wid = require('widget.github-activity-widget.github-activity-widget')

local systray_wid = wibox.widget.systray()
systray_wid:set_base_size(20)

local clock = wibox.widget.textclock(' [%l:%M.%S] | [%m/%d/%y] ', 1)

-- {{{ Per-screen init
awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.layouts[1])
	-- awful.tag({ '*', '*', '*', '*', '*', '*', '*', '*', '*' }, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(keys.layout_buttons)

	-- set the bar components
	s.taglist = bar.set_taglist(s)
	s.tasklist = bar.set_tasklist(s)

	-- vertical bar components
	-- s.taglist = bar.set_taglist_vert(s)
	-- s.tasklist = bar.set_tasklist_vert(s)
	-- {{{ Wibar
	-- Create horizontal wibox
	s.wibox = awful.wibar({
		position = 'top',
		screen = s,
		ontop = false,
		height = '27',
		bg = '#00000000',
	})

	-- create vertical wibox
	-- s.wibox = awful.wibar({
	-- 	position = 'left',
	-- 	screen = s,
	-- 	ontop = false,
	-- 	-- height = '27',
	--         width = '30',
	-- 	bg = '#00000000',
	-- })

	-- Vertical Wibar
	-- s.wibox:setup({
	-- 	layout = wibox.container.background,
	-- 	bg = '#00000000',
	-- 	{
	-- 		layout = wibox.container.margin,
	--             left = 5,
	--             top = 9,
	--             bottom = 9,
	--             right = 0,
	-- 		{
	-- 			layout = wibox.container.background,
	-- 			-- shape = gears.shape.rounded_bar,
	-- 			bg = beautiful.bg_normal,
	-- 			{
	-- 				layout = wibox.layout.align.vertical,
	-- 				{
	-- 					layout = wibox.layout.fixed.vertical,
	-- 					-- launcher,
	-- 					s.taglist,
	-- 					s.mypromptbox,
	-- 				},
	-- 				s.tasklist,
	-- 				{
	-- 					layout = wibox.container.margin,
	--                         margins = 0,
	-- 					{
	-- 						layout = wibox.layout.fixed.vertical,
	-- 						fs_wid({ mounts = { '/', '/home', '/mnt/xdrive' } }),
	-- 						clock,
	-- 						mpd_wid,
	-- 						systray_wid,
	-- 						gith_wid({
	-- 							username = 'Theory-of-Everything',
	-- 							number_of_events = '6',
	-- 						}),
	-- 						{
	-- 							widget = wibox.widget.textbox(' | '),
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- })

	-- horizontal wbar
	s.wibox:setup({
		layout = wibox.container.background,
		bg = '#00000000',
		{
			layout = wibox.container.margin,
			top = 5,
			bottom = 0,
			right = 9,
			left = 9,
			{
				layout = wibox.container.background,
				-- shape = gears.shape.rounded_bar,
				bg = beautiful.bg_normal,
				{
					layout = wibox.layout.align.horizontal,
					{
						layout = wibox.layout.fixed.horizontal,
						-- launcher,
						s.taglist,
						s.mypromptbox,
					},
					s.tasklist,
					{
						layout = wibox.container.margin,
						right = 1,
						top = 1,
						bottom = 1,
						{
							layout = wibox.layout.fixed.horizontal,
							fs_wid({ mounts = { '/', '/home', '/mnt/xdrive' } }),
							clock,
							-- mpd_wid,
							systray_wid,
							-- gith_wid({
							-- 	username = 'Theory-of-Everything',
							-- 	number_of_events = '6',
							-- }),
							{
								widget = wibox.widget.textbox(' | '),
							},
						},
					},
				},
			},
		},
	})
end)
-- }}}

-- }}}

tags = root.tags()

-- set keeb and mouse bindings
root.buttons(keys.desktop_buttons)
root.keys(keys.globalkeys)
