local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local keys = require('config.keys')

local M = {}

--{{{ custom theme options
--taglist colors
beautiful.taglist_fg_focus = beautiful.fg_normal
beautiful.taglist_bg_focus = beautiful.bg_normal
beautiful.taglist_squares_sel = beautiful.theme_assets.taglist_squares_sel(5, beautiful.fg_normal)
beautiful.taglist_squares_unsel = beautiful.theme_assets.taglist_squares_unsel(5, beautiful.bg_focus)
-- layout images
-- beautiful.layout_tile = beautiful.themes_path .. 'layouts/dark_tile.png'
-- beautiful.layout_tileleft = beautiful.themes_path .. 'layouts/dark_tileleft.png'
-- beautiful.layout_tilebottom = beautiful.themes_path .. 'layouts/dark_tilebottom.png'
-- beautiful.layout_tiletop = beautiful.themes_path .. 'layouts/dark_tiletop.png'
-- beautiful.layout_fairv = beautiful.themes_path .. 'layouts/dark_fairv.png'
-- beautiful.layout_fairh = beautiful.themes_path .. 'layouts/dark_fairh.png'
-- beautiful.layout_spiral = beautiful.themes_path .. 'layouts/dark_spiral.png'
-- beautiful.layout_dwindle = beautiful.themes_path .. 'layouts/dark_dwindle.png'
-- beautiful.layout_max = beautiful.themes_path .. 'layouts/dark_max.png'
-- beautiful.layout_fullscreen = beautiful.themes_path .. 'layouts/dark_fullscreen.png'
-- beautiful.layout_magnifier = beautiful.themes_path .. 'layouts/dark_magnifier.png'
-- beautiful.layout_floating = beautiful.themes_path .. 'layouts/dark_floating.png'
-- beautiful.layout_cornernw = beautiful.themes_path .. 'layouts/dark_cornernw.png'
-- beautiful.layout_cornerne = beautiful.themes_path .. 'layouts/dark_cornerne.png'
-- beautiful.layout_cornersw = beautiful.themes_path .. 'layouts/dark_cornersw.png'
-- beautiful.layout_cornerse = beautiful.themes_path .. 'layouts/dark_cornerse.png'
--}}}

-- {{{ Widgets
local fs_wid = require('widget.fs-widget.fs-widget')
local systray_wid = wibox.widget.systray()
systray_wid:set_base_size(20)
systray_wid:set_horizontal(false)
local clock = wibox.widget.textclock(' [%l:%M.%S] | [%m/%d/%y] ', 1)
-- }}}

-- {{{ Init func
local function set_bar(s)
	s.wibox = awful.wibar({
		position = 'left',
		screen = s,
		ontop = false,
		width = '34',
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
			bg_focus = beautiful.bg_normal,
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
			id = 'bg',
			bg = beautiful.green,
			fg = beautiful.bg_normal,
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
								id = 'icon_role',
								widget = wibox.widget.imagebox,
							},
							margins = 1,
							widget = wibox.container.margin,
						},
						widget = wibox.container.rotate,
					},
					-- {
					-- 	{
					-- 		id = 'text_role',
					-- 		widget = wibox.widget.textbox,
					-- 	},
					-- 	widget = wibox.container.rotate,
					-- 	direction = 'west',
					-- },
					-- layout = wibox.layout.fixed.vertical,
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
		bg = beautiful.bg_normal,
		{
			layout = wibox.container.margin,
			top = 7,
			bottom = 7,
			right = 1,
			{
				layout = wibox.container.background,
				-- shape = gears.shape.rounded_bar,
				bg = beautiful.bg_normal,
				{
					layout = wibox.container.margin,
					margins = 5,
					{
						layout = wibox.layout.align.vertical,
						{
							layout = wibox.layout.fixed.vertical,
							-- launcher,
							taglist,
							s.mypromptbox,
						},
						-- nil,
						tasklist,
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
	})
	-- }}}
end
-- }}}

function M.init(s)
	set_bar(s)
end

return M
