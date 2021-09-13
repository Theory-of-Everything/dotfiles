local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
require('awful.autofocus')

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal('request::titlebars', function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal('request::activate', 'titlebar', { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal('request::activate', 'titlebar', { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = 'center',
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal('mouse::enter', function(c)
--    c:emit_signal('request::activate', 'mouse_enter', {raise = false})
--end)

client.connect_signal('focus', function(c)
	c.border_color = beautiful.border_focus
	c.opacity = 1
end)
client.connect_signal('unfocus', function(c)
	c.border_color = beautiful.border_normal
	c.opacity = 1
end)

-- Toggle titlebar on or off depending on s. Creates titlebar if it doesn't exist
--local function setTitlebar(client, s)
--    if s then
--        if client.titlebar == nil then
--            client:emit_signal('request::titlebars', 'rules', {})
--        end
--        awful.titlebar.show(client)
--    else
--        awful.titlebar.hide(client)
--    end
--end

--Toggle titlebar on floating status change
--client.connect_signal('property::floating', function(c)
--    setTitlebar(c, c.floating)
--end)
--
-- Hook called when a client spawns
--client.connect_signal('manage', function(c)
--    setTitlebar(c, c.floating or c.first_tag.layout == awful.layout.suit.floating)
--end)
--
---- Show titlebars on tags with the floating layout
--tag.connect_signal('property::layout', function(t)
-- New to Lua ?
-- pairs iterates on the table and return a key value pair
-- I don't need the key here, so I put _ to ignore it
--    for _, c in pairs(t:clients()) do
--        if t.layout == awful.layout.suit.floating then
--            setTitlebar(c, true)
--        else
--            setTitlebar(c, false)
--        end
--    end
--end)

-- }}}
