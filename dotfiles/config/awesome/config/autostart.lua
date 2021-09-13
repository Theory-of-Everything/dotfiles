local awful = require ('awful')

-- display settings
awful.spawn.with_shell('autorandr --change --default default')
-- awful.spawn.with_shell('picom')
-- graphics
awful.spawn.with_shell('picom --experimental-backends')
awful.spawn.with_shell('nitrogen --restore')
awful.spawn.with_shell('sleep 3')

--systray items
awful.spawn.with_shell('pgrep -x udiskie > /dev/null || udiskie -t')
awful.spawn.with_shell('pgrep -x connman-ui-gtk > /dev/null/ || connman-ui-gtk')
-- awful.spawn.with_shell('pgrep -x nm-applet > /dev/null/ || nm-applet')
-- awful.spawn.with_shell('pgrep -x lxqt-connman-applet > /dev/null/ || lxqt-connman-applet')
-- awful.spawn.with_shell('pgrep -x conky > /dev/null/ || conky')

-- policykit agent
awful.spawn.with_shell('pgrep -x lxqt-policykit-agent > /dev/null/ || lxqt-policykit-agent')

-- daemons
awful.spawn.with_shell('pgrep -x mpd > /dev/null/ || mpd')
awful.spawn.with_shell('pgrep -x mpDris2 > /dev/null/ || mpDris2')
awful.spawn.with_shell('pgrep -x mpd_discord_richpresence --no-idle > /dev/null/ || mpd_discord_richpresence --no-idle')
awful.spawn.with_shell('pgrep -x syncthing serve > /dev/null/ || syncthing serve')
awful.spawn.with_shell('pgrep -x qtox > /dev/null/ || qtox')

-- wm session startup
awful.spawn.with_shell('pgrep -x lxsession > /dev/null/ || lxsession')
awful.spawn.with_shell('pgrep -x lxpolkit > /dev/null/ || lxpolkit')

-- essential services
awful.spawn.with_shell('pgrep -x protonmail-bridge --noninteractive > /dev/null/ || protonmail-bridge --noninteractive')
awful.spawn.with_shell('pgrep -x keepassxc > /dev/null/ || keepassxc')