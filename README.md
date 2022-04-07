## The Theory of Dots
Eyo! This is my repository with my dotfiles.
![](https://media.discordapp.net/attachments/489134425519685633/961521126578745354/unknown.png)

Some specs:

 - **WM:** [awesomeWM](https://github.com/awesomeWM/awesome/)
 - **Shell:** [zsh](https://wiki.archlinux.org/index.php/zsh)
 - **Terminal:** [urxvt](https://wiki.archlinux.org/index.php/rxvt-unicode)
 - **Editor:** [neovim](https://neovim.io)
 - **Application Launcher:** [rofi](https://github.com/davatorium/rofi/)
 - **File Manager:** [lf](https://github.com/gokcehan/lf)
 - **Browser:** Brave (heheh)

## The goal

The rationale behind these dots are to be as Keyboard-centric as possible,
eliminating mouse use as much as possible. However, these dots are also
designed to be usable in a more traditional stacking style of wm. Versatility
is key. Another key point is performance, as I want as much resources possible
available to apps that actually need it, not to my wm. These dots are a work in
progress, so expect things to not work or not be present.

Also note: Caps Lock is rebound to the Escape key (because capslock is useless)

## So what the hell are dotfiles?!?!?!?!
Dotfiles, in basic essence, are the Unix version of Windows hidden files.
Unlike Windows, dotfiles are mainly utilized for configuration of software. The
name dotfiles comes from a UNIX convention where hidden file's name starts with
a `.`(dot). This convention traces its origin back to old "feature" in `ls`
(remember: "Its not a bug, its a feature.") where files with a preceding `.`
would be hidden from output. People naturally exploited this "feature" to make
files hidden, and eventually it was adopted as standard. Remember: it's not a
bug; it's a feature!

## Keybinds:
#### Window Manipultion:
- `Mod` + `w` : Close/Kill Window 
- `Mod` + `j / k` : Focus Up/Down Stack
- `Mod` + `h / l` : Master Node Width Left/Right
- `Mod` + `e` : Pull Window to Master Node 

#### Tags
- `Mod` + `u / i` : Previous/Next Tag/Workspace
- `Mod` + `1 - 9` : Switch to Tag 1-9
- `Ctrl` + `Mod` + `1 - 9` : Pull Windows from Tags 1-9
- `Shift` + `Mod` + `1 - 9` : Send Windows to Tags 1-9

#### Media Keys (playerctl)
- `Mod` + `F5` : Previous Song
- `Mod` + `F6` : Toggle Playback
- `Mod` + `F7` : Next Song
- `Mod` + `F8` : Switch Playerctl source (supports only mpd and ncspot)

#### App Binds
- `Mod` + `Enter` : Opens Terminal
- `Mod` + `q` : Open App Launcher

#### Other
- `Shift` + `Mod` + `s` : Take Selection Screenshot

## So How do I install these?
Do some terminal warrior stuff:
```
git clone https://git.sr.ht/~theorytoe/dotfiles
cd dotfiles
git submodule update --init
```
Install the dots (NOTE: This will overwrites existing dotfiles)
```
./install
```
