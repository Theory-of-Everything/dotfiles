local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local gfs = gears.filesystem
local wibox = require("wibox")
local helpers = require("helpers")

local function generate_filter(t)
    return function(c, scr)
        local ctags = c:tags()
        for _, v in ipairs(ctags) do if v == t then return true end end
        return false
    end
end

local tasklist_buttons = gears.table.join(
                             awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
                             awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

-- The actual png icons
-- I do have the svgs, but inkscape does a better job of scaling
local ghost = gears.surface.load_uncached(
                  gfs.get_configuration_dir() .. "icons/ghosts/ghost.png")
local ghost_icon = gears.color.recolor_image(ghost, beautiful.xcolor6)
local dot = gears.surface.load_uncached(gfs.get_configuration_dir() ..
                                            "icons/ghosts/dot.png")
local dot_icon = gears.color.recolor_image(dot, beautiful.xcolor8)
local pacman = gears.surface.load_uncached(
                   gfs.get_configuration_dir() .. "icons/ghosts/pacman.png")
local pacman_icon = gears.color.recolor_image(pacman, beautiful.xcolor3)

-- Function to update the tags
local update_tags = function(self, c3)
    local imgbox = self:get_children_by_id('icon_role')[1]
    if c3.selected then
        imgbox.image = pacman_icon
    elseif #c3:clients() == 0 then
        imgbox.image = dot_icon
    else
        imgbox.image = ghost_icon
    end
end

function get_taglist(s)
    local screen_for_taglist = s or awful.screen.focused()

    local tagsklist = awful.widget.taglist {
        screen = screen_for_taglist,
        filter = awful.widget.taglist.filter.all,
        layout = {spacing = 8, layout = wibox.layout.fixed.vertical},
        widget_template = {
            {
                {
                    {
                        {
                            {id = 'icon_role', widget = wibox.widget.imagebox},
                            margins = {top = 7, left = 7, right = 7, bottom = 5},
                            widget = wibox.container.margin
                        },
                        bg = beautiful.xcolor0,
                        widget = wibox.container.background
                    },
                    {
                        {
                            id = "tasklist_role",
                            layout = wibox.layout.fixed.vertical
                        },
                         margins = {top = 2, left = 6, right = 6, bottom = 6},
                        widget = wibox.container.margin
                    },
                    spacing = 0,
                    layout = wibox.layout.fixed.vertical
                },
                shape = helpers.rrect(beautiful.border_radius),
                bg = beautiful.lighter_bg,
                widget = wibox.container.background
            },
            id = "background_role",
            widget = wibox.container.background,
            create_callback = function(self, c3, index, _)
                update_tags(self, c3)
                local t = screen_for_taglist.tags[index]
                self:get_children_by_id("tasklist_role")[1]:add(awful.widget
                                                                    .tasklist {
                    screen = screen_for_taglist,
                    filter = generate_filter(t),
                    buttons = tasklist_buttons,
                    layout = {spacing = 0, layout = wibox.layout.fixed.vertical},
                    widget_template = {
                        {
                            {
                                id = "clienticon",
                                widget = awful.widget.clienticon
                            },
                            top = 5,
                            widget = wibox.container.margin
                        },
                        create_callback = function(self, c, _, _)
                            self:get_children_by_id("clienticon")[1]:connect_signal(
                                'mouse::enter', function()
                                    awesome.emit_signal(
                                        "bling::task_preview::visibility",
                                        screen_for_taglist, true, c)
                                end)
                            self:get_children_by_id("clienticon")[1]:connect_signal(
                                'mouse::leave', function()
                                    awesome.emit_signal(
                                        "bling::task_preview::visibility",
                                        screen_for_taglist, false, c)
                                end)
                        end,
                        layout = wibox.layout.align.vertical
                    }
                })
                self:get_children_by_id("icon_role")[1]:connect_signal(
                    'mouse::enter', function()
                        if #c3:clients() > 0 then
                            awesome.emit_signal("bling::tag_preview::update", c3)
                            awesome.emit_signal(
                                "bling::tag_preview::visibility", s, true)
                        end
                    end)
                self:get_children_by_id("icon_role")[1]:connect_signal(
                    'mouse::leave', function()
                        awesome.emit_signal("bling::tag_preview::visibility", s,
                                            false)
                    end)
            end,
            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end
        }
    }

    return tagsklist
end

return get_taglist
