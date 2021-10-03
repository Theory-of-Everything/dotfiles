local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local keys = require('config.keys')

local bar = {}

function bar.set_taglist(s)
	local b = awful.widget.taglist({
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
	return b
end

function bar.set_tasklist(s)
	local b = awful.widget.tasklist({
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
	return b
end

function bar.set_taglist_vert(s)
	local b = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			shape = gears.shape.rectangle,
		},
		layout = {
			layout = wibox.layout.fixed.vertical,
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
					layout = wibox.layout.fixed.vertical,
				},
				top = 2.5,
				bottom = 2.5,
				left = 7,
				right = 5,
				widget = wibox.container.margin,
			},
			id = 'background_role',
			widget = wibox.container.background,
		},
		buttons = keys.taglist_buttons,
	})
	return b
end

function bar.set_tasklist_vert(s)
	local b = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = keys.tasklist_buttons,
		style = {
			-- shape_border_width = 0,
			-- shape_border_color = beautiful.border_normal,
			shape = gears.shape.rounded_bar,
		},
		layout = {
			layout = wibox.layout.flex.vertical,
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
							margins = 0,
							widget = wibox.container.margin,
						},
						widget = wibox.container.rotate,
					},
					{
						{
							id = 'text_role',
							widget = wibox.widget.textbox,
						},
						layout = wibox.layout.fixed.vertical,
					},
					widget = wibox.container.rotate,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = 'background_role',
			widget = wibox.container.background,
		},
	})
	return b
end

return bar
