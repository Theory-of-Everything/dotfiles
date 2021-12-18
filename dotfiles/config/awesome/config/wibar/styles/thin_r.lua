local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local keys = require('config.keys')

local M = {}

--{{{ custom theme options
--taglist colors
beautiful.taglist_fg_focus = beautiful.fg_normal
beautiful.taglist_bg_focus = beautiful.bg_focus
beautiful.taglist_squares_sel = beautiful.theme_assets.taglist_squares_sel(5, beautiful.fg_normal)
beautiful.taglist_squares_unsel = beautiful.theme_assets.taglist_squares_unsel(5, beautiful.bg_focus)
-- }}}

-- {{{ Widgets
local fs_wid = require('widget.fs-widget.fs-widget')
local systray_wid = wibox.widget.systray()
systray_wid:set_base_size(20)
systray_wid:set_horizontal(false)
local clock = wibox.widget.textclock(' [%l:%M.%S] | [%m/%d/%y] ', 2)
-- }}}

-- {{{ Init func
local function set_bar(s)
	s.wibox = awful.wibar({
		position = 'right',
		screen = s,
		ontop = false,
		width = '20',
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
							{
								{
									{
										id = 'index_role',
										widget = wibox.widget.textbox,
										text = '',
									},
									margins = 0,
									widget = wibox.container.margin,
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
				id = 'bg',
				bg = beautiful.green,
				fg = beautiful.bg_normal,
				widget = wibox.container.background,
			},
			layout = wibox.container.margin,
			top = 1,
			bottom = 1,
			right = 3,
			left = 3,
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
			shape = gears.shape.rectangle,
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
								margins = 2,
								widget = wibox.container.margin,
							},
							widget = wibox.container.rotate,
						},
						layout = wibox.container.margin,
						top = 8,
					},
					{
						{
							id = 'text_role',
							widget = wibox.widget.textbox,
						},
						widget = wibox.container.rotate,
						direction = 'west',
					},
					layout = wibox.layout.align.vertical,
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
	})
	-- }}}

	-- {{{ Wibox setup
	s.wibox:setup({
		layout = wibox.container.background,
		bg = '#00000000',
		{
			layout = wibox.container.margin,
			right = 4,
			top = 9,
			bottom = 9,
			left = 0,
			{
				layout = wibox.container.background,
				shape = gears.shape.rounded_bar,
				bg = beautiful.bg_normal,
				{
					layout = wibox.layout.align.vertical,
					{
						layout = wibox.layout.fixed.vertical,
						{
							layout = wibox.container.margin,
							top = 10,
							taglist,
						},
						-- launcher,
						s.mypromptbox,
					},
					tasklist,
					{
						layout = wibox.container.margin,
						margins = 0,
						{
							layout = wibox.layout.fixed.vertical,
							-- fs_wid({ mounts = { '/', '/home', '/mnt/xdrive' } }),
							{
								widget = wibox.container.rotate,
								direction = 'west',
								clock,
							},
							-- systray_wid,
							{
								layoutbox,
								widget = wibox.container.margin,
								top = 5,
								left = 2,
								right = 2,
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
	})
	-- }}}
end
-- }}}

function M.init(s)
	set_bar(s)
end

return M
