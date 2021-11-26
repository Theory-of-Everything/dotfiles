--  __ ___      _____  ___  ___  _ __ ___   _____      ___ __ ___
-- / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ \ /\ / / '_ ` _ \
--| (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/\ V  V /| | | | | |
-- \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___| \_/\_/ |_| |_| |_|
--
--
-- Theory's AwesomeWM Configs
--
-- {{{ Libraries
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
local bar = require('config.wibar')
local themeloader = require('lib.themeloader')
local bling = require('bling')
require('config')
require('misc')
-- }}}

-- {{{ Variable definitions
themeloader.set_global_theme('everforest')
-- themeloader.set_global_theme('bluewery')
-- themeloader.set_xres_theme('oxide')
-- themeloader.set_awesome_theme('everforest')

-- This is used later as the default terminal and editor to run.
terminal = 'urxvt'
scriptdir = os.getenv('SCRIPTDIR') or '$HOME/.config/scripts'

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.magnifier,
	awful.layout.suit.max,
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

-- {{{ Wallpaper Set/Update
local function set_wallpaper()
	-- Wallpaper
	awful.spawn.with_shell('nitrogen --restore')
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal('property::geometry', set_wallpaper)
-- }}}

-- {{{ Per-screen init
awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper()

	-- Each screen has its own tag table.
	awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.layouts[1])
	-- awful.tag({ '一', '二', '三', '四', '五', '六', 'セ', '八', '九' }, s, awful.layout.layouts[1])

	-- set wibars
	if s == screen.primary then
		bar.set_bar_style('block_vert_l')
		bar.init(s)
	else
		bar.set_bar_style('block_vert_r')
		bar.init(s)
	end
	-- bar.set_bar_style("tile")
	-- bar.init(s)
end)
-- }}}

-- {{{ Buttons/keys
tags = root.tags()

-- set keeb and mouse bindings
root.buttons(keys.desktop_buttons)
root.keys(keys.globalkeys)
-- }}}

-- local dash = require('gib.dash')
-- local test = dash:new({
-- 	opts = {
-- 		name = 'bruh moment',
-- 		placement = awful.placement.bottom,
-- 	},
-- })
-- test:spawn()

-- # vim: filetype=lua:foldmethod=marker
