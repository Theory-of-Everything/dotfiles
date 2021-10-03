local gears = require('gears')
local awful = require('awful')
local menubar = require('menubar')
local hotkeys_popup = require('awful.hotkeys_popup')
local musicctl = require('lib.musicctl')

local modkey = 'Mod4'

local keys = {}

-- {{{ Keyboard bindings
keys.globalkeys = gears.table.join(
	awful.key({ modkey }, 'comma', hotkeys_popup.show_help, { description = 'show help', group = 'awesome' }),
	awful.key({ modkey }, 'bracketleft', awful.tag.viewprev, { description = 'view previous', group = 'tag' }),
	awful.key({ modkey }, 'bracketright', awful.tag.viewnext, { description = 'view next', group = 'tag' }),
	awful.key({ modkey }, 'Escape', awful.tag.history.restore, { description = 'go back', group = 'tag' }),

	awful.key({ modkey }, 'j', function()
		awful.client.focus.byidx(1)
	end, {
		description = 'focus next by index',
		group = 'client',
	}),
	awful.key({ modkey }, 'k', function()
		awful.client.focus.byidx(-1)
	end, {
		description = 'focus previous by index',
		group = 'client',
	}),
	awful.key({ modkey }, 'F1', function()
		powermenu:show()
	end, {
		description = 'show main menu',
		group = 'awesome',
	}),

	-- Layout manipulation
	awful.key({ modkey, 'Shift' }, 'j', function()
		awful.client.swap.byidx(1)
	end, {
		description = 'swap with next client by index',
		group = 'client',
	}),
	awful.key({ modkey, 'Shift' }, 'k', function()
		awful.client.swap.byidx(-1)
	end, {
		description = 'swap with previous client by index',
		group = 'client',
	}),
	awful.key({ modkey, 'Control' }, 'j', function()
		awful.screen.focus_relative(1)
	end, {
		description = 'focus the next screen',
		group = 'screen',
	}),
	awful.key({ modkey, 'Control' }, 'k', function()
		awful.screen.focus_relative(-1)
	end, {
		description = 'focus the previous screen',
		group = 'screen',
	}),
	awful.key({ modkey }, 'u', awful.client.urgent.jumpto, { description = 'jump to urgent client', group = 'client' }),

	-- Standard program
	awful.key({ modkey }, 'Return', function()
		awful.spawn(terminal)
	end, {
		description = 'open a terminal',
		group = 'launcher',
	}),
	awful.key({ modkey, 'Control' }, 'r', awesome.restart, { description = 'reload awesome', group = 'awesome' }),
	awful.key({ modkey, 'Shift' }, 'q', awesome.quit, { description = 'quit awesome', group = 'awesome' }),

	awful.key({ modkey }, 'l', function()
		awful.tag.incmwfact(0.05)
	end, {
		description = 'increase master width factor',
		group = 'layout',
	}),
	awful.key({ modkey }, 'h', function()
		awful.tag.incmwfact(-0.05)
	end, {
		description = 'decrease master width factor',
		group = 'layout',
	}),
	awful.key({ modkey, 'Shift' }, 'h', function()
		awful.tag.incnmaster(1, nil, true)
	end, {
		description = 'increase the number of master clients',
		group = 'layout',
	}),
	awful.key({ modkey, 'Shift' }, 'l', function()
		awful.tag.incnmaster(-1, nil, true)
	end, {
		description = 'decrease the number of master clients',
		group = 'layout',
	}),
	awful.key({ modkey, 'Control' }, 'h', function()
		awful.tag.incncol(1, nil, true)
	end, {
		description = 'increase the number of columns',
		group = 'layout',
	}),
	awful.key({ modkey, 'Control' }, 'l', function()
		awful.tag.incncol(-1, nil, true)
	end, {
		description = 'decrease the number of columns',
		group = 'layout',
	}),
	awful.key({ modkey }, 'space', function()
		awful.layout.inc(1)
	end, {
		description = 'select next',
		group = 'layout',
	}),
	awful.key({ modkey, 'Shift' }, 'space', function()
		awful.layout.inc(-1)
	end, {
		description = 'select previous',
		group = 'layout',
	}),

	awful.key({ modkey, 'Control' }, 'n', function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal('request::activate', 'key.unminimize', { raise = true })
		end
	end, {
		description = 'restore minimized',
		group = 'client',
	}),

	-- Prompt
	awful.key({ modkey }, 'q', function()
		awful.spawn.with_shell('rofi -show run ')
	end, {
		description = 'run prompt',
		group = 'launcher',
	}),

	awful.key({ modkey }, 'Tab', function()
		awful.spawn.with_shell('rofi -show window ')
	end, {
		description = 'window swtch promt',
		group = 'launcher',
	}),

	awful.key({ modkey }, 'g', function()
		awful.spawn.with_shell('~/.config/scripts/gamelauncher.sh')
	end, {
		description = 'game launcher',
		group = 'launcher',
	}),

	awful.key({ modkey }, 'x', function()
		awful.prompt.run({
			prompt = 'Run Lua code: ',
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. '/history_eval',
		})
	end, {
		description = 'lua execute prompt',
		group = 'awesome',
	}),
	-- Menubar
	awful.key({ modkey }, 'p', function()
		menubar.show()
	end, {
		description = 'show the menubar',
		group = 'launcher',
	}),
	-- Power State Ctl
	awful.key({ modkey }, 'F12', function()
		awful.spawn.with_shell(scriptdir .. '/pwrctl.sh')
	end, {
		description = 'show the menubar',
		group = 'launcher',
	}),

	-- Scrots
	-- Full Scrot
	awful.key({ modkey }, 'Insert', function()
		awful.spawn.with_shell('$HOME/.local/bin/scripts/scrnshot.sh')
	end, {
		description = 'take a screenshot',
		group = 'utils',
	}),
	-- Selection Scrot
	awful.key({ modkey, 'Shift' }, 's', function()
		awful.spawn.with_shell('$HOME/.config/scripts/scrnclip.sh')
	end, {
		description = 'take a screen clip (playerctl)',
		group = 'utils',
	}),
	-- playerctl music control
	awful.key({ modkey }, 'F5', function()
		musicctl.playback_previous()
	end, {
		description = 'play previous song (playerctl)',
		group = 'music',
	}),
	awful.key({ modkey }, 'F6', function()
		musicctl.playback_toggle()
	end, {
		description = 'toggle music playback (playerctl)',
		group = 'music',
	}),
	awful.key({ modkey }, 'F7', function()
		musicctl.playback_next()
	end, {
		description = 'play next song (playerctl)',
		group = 'music',
	}),
	awful.key({ modkey }, 'F8', function()
		musicctl.switch_mode()
	end, {
		description = 'switch playerctl mode',
		group = 'music',
	}),

	-- scratchpad keys
	awful.key({ modkey }, 'F11', function()
		awesome.emit_signal('term_scratch::turn_on')
	end, {
		description = 'Open Terminal Scratch',
		group = 'scratch',
	})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	keys.globalkeys = gears.table.join(
		keys.globalkeys,
		-- View tag only.
		awful.key({ modkey }, '#' .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, {
			description = 'view tag #' .. i,
			group = 'tag',
		}),
		-- Toggle tag display.
		awful.key({ modkey, 'Control' }, '#' .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, {
			description = 'toggle tag #' .. i,
			group = 'tag',
		}),
		-- Move client to tag.
		awful.key({ modkey, 'Shift' }, '#' .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, {
			description = 'move focused client to tag #' .. i,
			group = 'tag',
		}),
		-- Toggle tag on focused client.
		awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, {
			description = 'toggle focused client on tag #' .. i,
			group = 'tag',
		})
	)
end

-- keybinds for each individual window (client) that is window-speciphic
keys.clientkeys = gears.table.join(
	awful.key({ modkey }, 'f', function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, {
		description = 'toggle fullscreen',
		group = 'client',
	}),
	awful.key({ modkey }, 'w', function(c)
		c:kill()
	end, { description = 'close', group = 'client' }),
	awful.key(
		{ modkey, 'Control' },
		'space',
		awful.client.floating.toggle,
		{ description = 'toggle floating', group = 'client' }
	),
	awful.key({ modkey }, 'e', function(c)
		c:swap(awful.client.getmaster())
	end, {
		description = 'move to master',
		group = 'client',
	}),
	awful.key({ modkey }, 'o', function(c)
		c:move_to_screen()
	end, {
		description = 'move to screen',
		group = 'client',
	}),
	awful.key({ modkey }, 't', function(c)
		c.ontop = not c.ontop
	end, {
		description = 'toggle keep on top',
		group = 'client',
	}),
	awful.key({ modkey }, 'n', function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, {
		description = 'minimize',
		group = 'client',
	}),
	awful.key({ modkey }, 'm', function(c)
		c.maximized = not c.maximized
		c:raise()
	end, {
		description = '(un)maximize',
		group = 'client',
	}),
	awful.key({ modkey, 'Control' }, 'm', function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, {
		description = '(un)maximize vertically',
		group = 'client',
	}),
	awful.key({ modkey, 'Shift' }, 'm', function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, {
		description = '(un)maximize horizontally',
		group = 'client',
	})
)
-- end keyboard bindings }}}

-- {{{ Mouse bindings
keys.taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

-- Create mouse bindings for the tasklist widget
keys.tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal('request::activate', 'tasklist', { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)
keys.clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal('request::activate', 'mouse_click', { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal('request::activate', 'mouse_click', { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal('request::activate', 'mouse_click', { raise = true })
		awful.mouse.client.resize(c)
	end)
)
-- mouse bindings for the desktop
keys.desktop_buttons = gears.table.join(
	-- awful.button({}, 3, function()
	-- 	    powermenu:toggle()
	--end)
)

keys.layout_buttons = gears.table.join(
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
	end)
)
-- }}}

return keys
