local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local keys = require('config.keys')

local M = {}

local fs_wid = require('widget.fs-widget.fs-widget')
local systray_wid = wibox.widget.systray()
systray_wid:set_base_size(20)
local clock = wibox.widget.textclock(' [%l:%M.%S] | [%m/%d/%y] ', 1)

-- {{{ Init func
local function set_bar(s)
	s.wibox = awful.wibar({
		position = 'bottom',
		screen = s,
		ontop = false,
		height = '27',
		bg = '#00000000',
	})

	-- {{{ Taglist
	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			shape = gears.shape.rectangle,
		},
		layout = {
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					{
						{
							id = 'index_role',
							widget = wibox.widget.textbox,
						},
						margins = 0,
						widget = wibox.container.margin,
					},
					{
						id = 'text_role',
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 5,
				right = 5,
				widget = wibox.container.margin,
			},
			id = 'background_role',
			widget = wibox.container.background,
		},
		buttons = keys.taglist_buttons,
	})
	-- }}}

	-- {{{ Tasklist
	local tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = keys.tasklist_buttons,
		style = {
			-- shape_border_width = 1,
			-- shape_border_color = beautiful.border_normal,
			shape = gears.shape.rectangle,
		},
		layout = {
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				{
					{
						{
							id = 'icon_role',
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget = wibox.container.margin,
					},
					{
						id = 'text_role',
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = 'background_role',
			widget = wibox.container.background,
		},
	})
	-- }}}

	-- {{{ Wibox setup
	s.wibox:setup({
		layout = wibox.container.background,
		bg = '#00000000',
		{
			layout = wibox.container.margin,
			top = 0,
			bottom = 5,
			right = 10,
			left = 10,
			{
				layout = wibox.container.background,
				-- shape = gears.shape.rounded_bar,
				bg = beautiful.bg_normal,
				{
					layout = wibox.layout.align.horizontal,
					{
						layout = wibox.layout.fixed.horizontal,
						-- launcher,
						taglist,
					},
					tasklist,
					{
						layout = wibox.container.margin,
						right = 1,
						top = 1,
						bottom = 1,
						{
							layout = wibox.layout.fixed.horizontal,
							fs_wid({ mounts = { '/', '/home', '/mnt/xdrive' } }),
							clock,
							systray_wid,
							{
								widget = wibox.widget.textbox(' | '),
							},
						},
					},
				},
			},
		},
	})
	-- }}}
end
-- }}}

function M.init(s)
	set_bar(s)
end

return M
