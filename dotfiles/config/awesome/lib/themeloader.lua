local awful = require('awful')
local beautiful = require('beautiful')
local themes_dir = os.getenv('HOME') .. '/.config/awesome/themes'

local M = {}

M.set_awesome_theme = function(arg)
	local selected_theme = '/' .. arg
	beautiful.init(themes_dir .. selected_theme .. '/themeopts.lua')
end

M.set_xres_theme = function(arg)
	local selected_theme = '/' .. arg
	awful.spawn.with_shell('xrdb -load ' .. themes_dir .. selected_theme .. '/xres_theme')
end

M.set_global_theme = function(choice)
	M.set_xres_theme(choice)
	M.set_awesome_theme(choice)
end

return M
