## The Theory of Dots
Eyo! This is my repository with my dotfiles.
<img src="https://raw.githubusercontent.com/Theory-of-Everything/imagehost/main/dotfiles/rice-sidebar.png" alt="img" align="right" width="350px">

The setup wiki page will guide you through installing my setup.

Some specs:

 - **Distribution:** Arch Linux
 - **WM:** [awesomeWM](https://github.com/awesomeWM/awesome/)
 - **Shell:** [zsh](https://wiki.archlinux.org/index.php/zsh)
 - **Terminal:** [urxvt](https://wiki.archlinux.org/index.php/rxvt-unicode)
 - **Editor:** [neovim](https://neovim.io)
 - **Application Launcher:** [rofi](https://github.com/davatorium/rofi/)
 - **File Manager:** [Thunar](https://wiki.archlinux.org/title/Thunar)
 - **Browser:** Brave (heheh)

## The goal

The rationale behind these dots are to be as Keyboard-centric as possible, elimainating mouse use as much as possible. However, these dots are also designed to be usable in a more traditional stacking style of wm. Versatility is key. Another key point is performace, as I want as much resources possible avalible to apps that actually need it, not to my wm.
These dots are a work in progress, so expect things to not work or not be present.

Also note: Caps Lock is rebound to the Escape key (because capslock is useless)

## So what the hell are dotfiles?!?!?!?!
Dotfiles in basic essence are the Unix version of Windows hidden files. Unlike Windows, dotfiles are mainly utilized for configuration of software. The name dotfiles comes from a UNIX convention where hidden file's name starts with a `.`(dot). This convention traces its origin back to old "feature" in `ls` (remember: "Its not a bug, its a feature.") where files with a preceding `.` would be hidden from output. People natrually exploited this "feature" to make files hidden, adn eventually it was adopted as standard. Remember: it's not a bug; it's a feature!

## Keybinds:
#### Window Manipultion:
- <kbd> Mod </kbd> + <kbd> w </kbd> : Close/Kill Window 
- <kbd> Mod </kbd> + <kbd> j </kbd> / <kbd> J </kbd> : Focus Up/Down Stack
- <kbd> Mod </kbd> + <kbd> h </kbd> / <kbd> L </kbd> : Master Node Width Left/Right
- <kbd> Mod </kbd> + <kbd> e </kbd> : Pull Window to Master Node 

#### Tags
- <kbd> Mod </kbd> + <kbd> [ </kbd> / <kbd> ] </kbd> : Previous/Next Tag/Workspace
- <kbd> Mod </kbd> + <kbd> 1 </kbd> - <kbd> 9 </kbd> : Switch to Tag 1-9
- <kbd> Ctrl </kbd> + <kbd> Mod </kbd> + <kbd> 1 </kbd> - <kbd> 9 </kbd> : Pull Windows from Tags 1-9
- <kbd> Shift </kbd> + <kbd> Mod </kbd> + <kbd> 1 </kbd> - <kbd> 9 </kbd> : Send Windows to Tags 1-9

#### Media Keys (playerctl)
- <kbd> Mod </kbd> + <kbd> F5 </kbd>: Previous Song
- <kbd> Mod </kbd> + <kbd> F6 </kbd>: Toggle Playback
- <kbd> Mod </kbd> + <kbd> F7 </kbd>: Next Song
- <kbd> Mod </kbd> + <kbd> F8 </kbd>: Switch Playerctl source (supports only mpd and ncspot)

#### App Binds
- <kbd> Mod </kbd> + <kbd> Enter </kbd> : Opens Terminal
- <kbd> Mod </kbd> + <kbd> q </kbd> : Open App Launcher

#### Other
- <kbd> Shift </kbd> + <kbd> Mod </kbd> + <kbd> s </kbd> : Take Selection Screenshot

## So How do I install these?
Do some terminal warrior stuff:
```
$ git clone https://github.com/Theory-of-Everything/dotfiles
$ cd dotfiles
```
Update the submodules:
```
$ git submodule update --recursive
```
Install the dots (NOTE: This will overwite exsisting dotfiles)
```
$ ./dotdrop.sh install inkmachine
```
