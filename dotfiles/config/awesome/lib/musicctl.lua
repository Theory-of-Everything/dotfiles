local naughty = require('naughty')
local awful = require('awful')

local M = {}

M.modes = { 'mpd', 'ncspot' }
M.current_mode = 'mpd'

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

M.playback_toggle = function()
	awful.spawn.with_shell('playerctl --player ' .. M.current_mode .. ' play-pause')
end

M.playback_next = function()
	awful.spawn.with_shell('playerctl --player ' .. M.current_mode .. ' next')
end

M.playback_previous = function()
	awful.spawn.with_shell('playerctl --player ' .. M.current_mode .. ' previous')
end

return M
