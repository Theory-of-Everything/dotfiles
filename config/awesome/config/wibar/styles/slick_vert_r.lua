local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local cairo = require('lgi').cairo
local beautiful = require('beautiful')
local helpers = require('lib.helpers')
local keys = require('config.keys')

local M = {}

-- {{{ Widgets
local fs_wid = require('widget.fs-widget.fs-widget')
local systray_wid = wibox.widget.systray()
systray_wid:set_base_size(20)
systray_wid:set_horizontal(false)
-- hacky buit it works kek
beautiful.bg_systray = beautiful.bg_focus

-- systray_wid:set_base_size(20)
-- systray_wid:set_horizontal(false)
local clock = wibox.widget.textclock(' [%l:%M %m/%d/] ', 1)
-- }}}

-- {{{ Init func
local function set_bar(s)
	s.wibox = awful.wibar({
		position = 'right',
		screen = s,
		ontop = false,
		width = '36',
		bg = '#00000000',
	})

	-- {{{ layoutbox
	local layoutbox = awful.widget.layoutbox({
		screen = s,
		-- Add buttons, allowing you to change the layout
		buttons = {
			awful.button({}, 1, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 3, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 4, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 5, function()
				awful.layout.inc(-1)
			end),
		},
	})
	-- }}}

	-- {{{ Taglist
	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			-- shape = gears.shape.rectangle,
			shape = helpers.rrect(5),
			fg_focus = beautiful.bg_normal,
			bg_focus = beautiful.green,
			fg_empty = beautiful.fg_focus,
			bg_empty = beautiful.bg_focus,
			fg_occupied = beautiful.fg_focus,
			bg_occupied = beautiful.bg_focus,
		},
		layout = {
			layout = wibox.layout.fixed.vertical,
		},
		widget_template = {
			{
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
					halign = 'center',
					widget = wibox.container.place,
				},
				top = 5,
				bottom = 5,
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
			bg_focus = beautiful.green,
			fg_normal = beautiful.fg_focus,
			bg_normal = beautiful.bg_focus,
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
								{
									id = 'icon_role',
									widget = wibox.widget.imagebox,
								},
								margins = 1,
								widget = wibox.container.margin,
							},
							widget = wibox.container.rotate,
						},
						{
							{
								id = 'text_role',
								widget = wibox.widget.textbox,
							},
							widget = wibox.container.rotate,
							direction = 'west',
						},
						layout = wibox.layout.fixed.vertical,
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
			top = 2,
			bottom = 2,
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
			left = 0,
			top = 7,
			bottom = 7,
			right = 5,
			{
				layout = wibox.container.background,
				shape = helpers.rrect(5),
				-- shape = gears.shape.rounded_bar,
				bg = beautiful.bg_normal,
				{
					layout = wibox.container.margin,
					left = 5,
					top = 5,
					bottom = 5,
					right = 5,

					{
						layout = wibox.layout.align.vertical,
						{
							layout = wibox.layout.fixed.vertical,
							-- launcher,
							{
								layout = wibox.container.background,
								shape = helpers.rrect(5),
								bg = beautiful.bg_focus,
								{
									layout = wibox.container.margin,
									top = 3,
									bottom = 3,
									left = 1,
									right = 1,
									taglist,
								},
							},
							s.mypromptbox,
						},
						{
							layout = wibox.container.margin,
							top = 5,
							bottom = 5,
							tasklist,
						},
						{
							layout = wibox.container.background,
							shape = helpers.rrect(5),
							bg = beautiful.bg_focus,
							{
								layout = wibox.container.margin,
								top = 3,
								bottom = 3,
								left = 2,
								right = 2,
								{
									layout = wibox.container.margin,
									margins = 0,
									{
										layout = wibox.layout.fixed.vertical,
										fs_wid({ mounts = { '/', '/home', '/mnt/xdrive' } }),
										{
											widget = wibox.container.rotate,
											direction = 'west',
											clock,
										},
										systray_wid,
										{
											layoutbox,
											widget = wibox.container.margin,
											top = 5,
											left = 1,
											right = 1,
										},
										{
											widget = wibox.container.rotate,
											direction = 'west',
											{
												widget = wibox.widget.textbox(' | '),
											},
										},
									},
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
