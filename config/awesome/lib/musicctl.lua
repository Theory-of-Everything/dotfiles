local naughty = require('naughty')
local wibox = require('wibox')
local beautiful = require('beautiful')
local awful = require('awful')

local M = {}

M.modes = { 'mpd', 'ncspot' }
M.current_mode = 'mpd'
M.vol_inc_amt = '0.01' -- This MUST be a string
M.muted = false -- wip

-- TODO: Add volume control widget

-- M.notif = function()
-- 	naughty.notification({
-- 		-- title = 'Playerctl',
-- 		position = "top_middle",
-- 		widget_template = {
-- 			{ -- container in margin
-- 				{
-- 					{
-- 						text = "Test",
-- 						valign = 'center',
-- 						widget = wibox.widget.textbox,
-- 					},
-- 					{
-- 						text = "Bruh",
-- 						valign = 'center',
-- 						widget = wibox.widget.textbox,
-- 					},
-- 					spacing = 8,
-- 					layout = wibox.layout.fixed.horizontal,
-- 				},
-- 				widget = wibox.container.margin(self, 20, 20, 4, 4),
-- 			},
-- 			bg = beautiful.bg_normal,
-- 			opacity = 0.9,
-- 			widget = naughty.container.background,
-- 		},
-- 	})
-- end

-- {{{ Mode Switch
M.switch_mode = function()
	if M.current_mode == 'mpd' then
		M.current_mode = 'ncspot'
		naughty.notify({
			text = 'Switched playerctl mode to ' .. M.current_mode,
			title = 'Playerctl Switcher',
			icon = os.getenv('HOME') .. '/.config/awesome/resources/icons/playlist-music-outline.png',
			run = function()
				awful.spawn.with_shell('urxvt -e ncspot')
			end,
		})
	else
		M.current_mode = 'mpd'
		naughty.notify({
			text = 'Switched playerctl mode to ' .. M.current_mode,
			title = 'Playerctl Switcher',
			icon = os.getenv('HOME') .. '/.config/awesome/resources/icons/playlist-music-outline.png',
			icon_size = 200,
			run = function()
				awful.spawn.with_shell('urxvt -e ncmpcpp')
			end,
		})
	end
end
-- }}}

-- {{{ Playback control
M.playback_toggle = function()
	awful.spawn.with_shell('playerctl --player=' .. M.current_mode .. ' play-pause')
end

M.playback_next = function()
	awful.spawn.with_shell('playerctl --player=' .. M.current_mode .. ' next')
end

M.playback_previous = function()
	awful.spawn.with_shell('playerctl --player=' .. M.current_mode .. ' previous')
end
-- }}}

-- {{{ Volume Control
-- incremental control (increment polarity must follow the number)
-- vol_increment('0.1-') vol down
M.vol_increment = function(a)
	awful.spawn.with_shell('playerctl --player=' .. M.current_mode .. ' volume ' .. a)
end

-- vol up
M.vol_up = function()
	awful.spawn.with_shell('playerctl --player=' .. M.current_mode .. ' volume ' .. M.vol_inc_amt .. '+')
end

-- vol down
M.vol_down = function()
	awful.spawn.with_shell('playerctl --player=' .. M.current_mode .. ' volume ' .. M.vol_inc_amt .. '+-')
end

-- mute volume
-- TODO: add togle functionality
M.vol_mute = function()
	awful.spawn.with_shell('playerctl --player=' .. M.current_mode .. ' volume 0')
end

-- max volume
M.vol_blast = function()
	awful.spawn.with_shell('playerctl --player=' .. M.current_mode .. ' volume 1')
end

-- }}}

return M
