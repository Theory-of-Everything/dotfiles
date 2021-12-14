-------------------------------
--  'Zenburn' awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

local themes_path = os.getenv('HOME') .. ".config/awesome/themes/oxide/"
local beautiful = require('beautiful')
local dpi = require('beautiful.xresources').apply_dpi

-- {{{ Main
local theme = {}
--theme.wallpaper = themes_path .. 'zenburn-background.png'
-- }}}

-- {{{ Styles
theme.font = 'cozette 10'

-- {{{ Colors
theme.fg_normal = '#DCDCCC'
theme.fg_focus = '#DCDCCC'
theme.fg_urgent = '#DCDCCC'
-- theme.bg_normal = '#1c1e21'
theme.bg_normal = '#18181b'
-- theme.bg_focus = '#363636'
-- theme.bg_focus = '#21252d'
theme.bg_focus = '#212d2c'
theme.bg_urgent = '#CE3C65'
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap = dpi(4)
theme.border_width = dpi(2)
theme.border_normal = '#3F3F3F'
theme.border_focus = '#6F6F6F'
theme.border_marked = '#CC9393'
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus = '#5F5F5F'
theme.titlebar_bg_normal = '#3F3F3F'
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = '#CC9393'
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.fg_widget        = '#AECF96'
-- theme.fg_center_widget = '#88A175'
-- theme.fg_end_widget    = '#FF5656'
-- theme.bg_widget        = '#494B4F'
-- theme.border_widget    = '#3F3F3F'
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = '#CC9393'
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
-- theme.taglist_squares_sel = themes_path .. 'taglist/squarefz.png'
-- theme.taglist_squares_unsel = themes_path .. 'taglist/squarez.png'
-- bar like ones
-- theme.taglist_squares_sel = themes_path .. 'taglist/bar1fz.png'
-- theme.taglist_squares_unsel = themes_path .. 'taglist/bar1z.png'
theme.taglist_squares_sel = beautiful.theme_assets.taglist_squares_sel(5, theme.fg_normal)
theme.taglist_squares_unsel = beautiful.theme_assets.taglist_squares_unsel(5, theme.fg_focus)
--theme.taglist_squares_resize = 'false'
-- }}}

-- {{{ Misc
theme.pfp_icon = themes_path .. 'pfp.png'
theme.poweroff_icon = themes_path .. 'poweroff.png'
theme.awesome_icon = themes_path .. 'awesome-icon.png'
theme.menu_submenu_icon = themes_path .. 'default/submenu.png'
-- }}}

-- {{{ Layout
theme.layout_tile = themes_path .. 'layouts/tile.png'
theme.layout_tileleft = themes_path .. 'layouts/tileleft.png'
theme.layout_tilebottom = themes_path .. 'layouts/tilebottom.png'
theme.layout_tiletop = themes_path .. 'layouts/tiletop.png'
theme.layout_fairv = themes_path .. 'layouts/fairv.png'
theme.layout_fairh = themes_path .. 'layouts/fairh.png'
theme.layout_spiral = themes_path .. 'layouts/spiral.png'
theme.layout_dwindle = themes_path .. 'layouts/dwindle.png'
theme.layout_max = themes_path .. 'layouts/max.png'
theme.layout_fullscreen = themes_path .. 'layouts/fullscreen.png'
theme.layout_magnifier = themes_path .. 'layouts/magnifier.png'
theme.layout_floating = themes_path .. 'layouts/floating.png'
theme.layout_cornernw = themes_path .. 'layouts/cornernw.png'
theme.layout_cornerne = themes_path .. 'layouts/cornerne.png'
theme.layout_cornersw = themes_path .. 'layouts/cornersw.png'
theme.layout_cornerse = themes_path .. 'layouts/cornerse.png'
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus = themes_path .. 'titlebar/close_focus.png'
theme.titlebar_close_button_normal = themes_path .. 'titlebar/close_normal.png'

theme.titlebar_minimize_button_normal = themes_path .. 'titlebar/minimize_normal.png'
theme.titlebar_minimize_button_focus = themes_path .. 'titlebar/minimize_focus.png'

theme.titlebar_ontop_button_focus_active = themes_path .. 'titlebar/ontop_focus_active.png'
theme.titlebar_ontop_button_normal_active = themes_path .. 'titlebar/ontop_normal_active.png'
theme.titlebar_ontop_button_focus_inactive = themes_path .. 'titlebar/ontop_focus_inactive.png'
theme.titlebar_ontop_button_normal_inactive = themes_path .. 'titlebar/ontop_normal_inactive.png'

theme.titlebar_sticky_button_focus_active = themes_path .. 'titlebar/sticky_focus_active.png'
theme.titlebar_sticky_button_normal_active = themes_path .. 'titlebar/sticky_normal_active.png'
theme.titlebar_sticky_button_focus_inactive = themes_path .. 'titlebar/sticky_focus_inactive.png'
theme.titlebar_sticky_button_normal_inactive = themes_path .. 'titlebar/sticky_normal_inactive.png'

theme.titlebar_floating_button_focus_active = themes_path .. 'titlebar/floating_focus_active.png'
theme.titlebar_floating_button_normal_active = themes_path .. 'titlebar/floating_normal_active.png'
theme.titlebar_floating_button_focus_inactive = themes_path .. 'titlebar/floating_focus_inactive.png'
theme.titlebar_floating_button_normal_inactive = themes_path .. 'titlebar/floating_normal_inactive.png'

theme.titlebar_maximized_button_focus_active = themes_path .. 'titlebar/maximized_focus_active.png'
theme.titlebar_maximized_button_normal_active = themes_path .. 'titlebar/maximized_normal_active.png'
theme.titlebar_maximized_button_focus_inactive = themes_path .. 'titlebar/maximized_focus_inactive.png'
theme.titlebar_maximized_button_normal_inactive = themes_path .. 'titlebar/maximized_normal_inactive.png'
-- }}}

-- {{{ Notifications
theme.notification_icon_size = 100
theme.notification_max_height = 300
theme.notification_max_width = 500
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=4:softtabstop=4:textwidth=80
