local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local helpers = require('lib.helpers')
local beautiful = require('beautiful')
local keys = require('config.keys')

local M = {}

local fs_wid = require('widget.fs-widget.fs-widget')
local systray_wid = wibox.widget.systray()
systray_wid:set_base_size(20)
beautiful.bg_systray = beautiful.bg_focus
local clock = wibox.widget.textclock(' [%l:%M.%S] | [%m/%d/%y] ', 1)

-- {{{ Init func
local function set_bar(s)
	s.wibox = awful.wibar({
		position = 'top',
		screen = s,
		ontop = false,
		height = '34',
		bg = '#00000000',
	})

	-- {{{ Taglist
	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			shape = helpers.rrect(5),
			fg_focus = beautiful.bg_normal,
			bg_focus = beautiful.green,
			fg_empty = beautiful.fg_focus,
			bg_empty = beautiful.bg_focus,
			fg_occupied = beautiful.fg_focus,
			bg_occupied = beautiful.bg_focus,
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
			-- shape_border_width = 0,
			-- shape_border_color = beautiful.border_normal,
			-- shape = gears.shape.rectangle,
			shape = helpers.rrect(5),
			fg_focus = beautiful.bg_normal,
			bg_focus = beautiful.red,
			fg_normal = beautiful.fg_focus,
			bg_normal = beautiful.bg_focus,
		},
		layout = {
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				{
					{
						{
							{
								id = 'icon_role',
								widget = wibox.widget.imagebox,
							},
							margins = 1,
							widget = wibox.container.margin,
						},
						{
							id = 'text_role',
							widget = wibox.widget.textbox,
						},
						layout = wibox.layout.fixed.horizontal,
					},
					top = 1,
					bottom = 1,
					left = 1,
					right = 1,
					widget = wibox.container.margin,
				},
				id = 'background_role',
				widget = wibox.container.background,
			},
			right = 2,
			left = 2,
			widget = wibox.container.margin,
		},
	})

	-- }}}

	-- {{{ Wibox setup
	s.wibox:setup({
		layout = wibox.container.background,
		bg = '#00000000',
		{
			layout = wibox.container.margin,
			top = 5,
			bottom = 0,
			right = 10,
			left = 10,
			{
				layout = wibox.container.background,
				shape = helpers.rrect(5),
				bg = beautiful.bg_normal,
				{
					layout = wibox.layout.align.horizontal,
					{
						layout = wibox.container.background,
						shape = helpers.rrect(5),
						bg = beautiful.bg_normal,
						{
							layout = wibox.container.margin,
							left = 5,
							top = 4,
							bottom = 4,
							right = 5,
							{
								layout = wibox.container.background,
								shape = helpers.rrect(5),
								bg = beautiful.bg_focus,
								{
									layout = wibox.container.margin,
									top = 1,
									bottom = 1,
									left = 1,
									right = 1,
									taglist,
								},
							},
						},
					},
					{
						layout = wibox.container.margin,
						top = 5,
						bottom = 5,
						tasklist,
					},
					{
						layout = wibox.container.margin,
						right = 1,
						left = 1,
						top = 5,
						bottom = 5,
						{
							layout = wibox.container.background,
							shape = helpers.rrect(5),
							bg = beautiful.bg_focus,
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
		},
	})
	-- }}}
end
-- }}}

function M.init(s)
	set_bar(s)
end

return M
