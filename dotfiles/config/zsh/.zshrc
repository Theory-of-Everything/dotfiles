clear


# {{{ compinit/autoload
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 5 numeric
zstyle ':completion:*' menu select=5
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/theorytoe/.config/zsh/.zshrc'

# autoload
autoload -Uz compinit promptinit
autoload -U colors && colors
autoload edit-command-line; zle -N edit-command-line
autoload -Uz vcs_info
compinit
promptinit
# }}}

# {{{ opts
zle_highlight=('paste:none')
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT='${vcs_info_msg_0_}'
zstyle ':vcs_info:git:*' formats '%b '

# PS1 Prompt
PS1='%B%F{green}[%n@%m\ %F{blue}${vcs_info_msg_0_}%F{green}%F{red}%1~%F{green}]%F{blue}%F{green} => %f%b'
PS2='%B%F{green}[%F{red}*%F{green}] => %f%b '

bindkey -v

xset r rate 215 45
xset m 0 0

HISTFILE=~/.config/zsh/.zhist
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep

ZSH_AUTOSUGGEST_STRATEGY=(history)

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}

bindkey '^e' edit-command-line

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q'                # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt.
# }}}

# {{{ Enviroment Vars
append_path() {
    case ":$PATH:" in
    *:"$1":*) ;;

    *)
        PATH="${PATH:+$PATH:}$1"
        ;;
    esac
}

append_path "$HOME/.config/scripts"
append_path "$HOME/.cargo/bin"

if [ -d "$HOME/.local/bin" ] && (! echo $PATH | grep -q "$HOME/.local/bin"); then
    export PATH="$HOME/.local/bin:$PATH"
fi

export QT_QPA_PLATFORMTHEME=qt5ct

# app enviros
#DONT SET BECAUSE THIS WILL BREAK TMUX
# export TERM=xterm-256color 
export EDITOR="nvim"
export FILEMAN=thunar
export VIDPLAYER=mpv
export IMGVIEWER=feh
export AUDPLAYER=cmus
export WEBBROWSER=brave
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
export COLORTERM="truecolor"

# export SUDO_PROMPT="[sudo] PASSWORD NOW RETARD!!!  "

# other enviros
export MPD_OPTS="$HOME/.conf/mpd/mpd.conf"
# }}}

# {{{ Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# vim-like shorcuts
alias ':q'="exit"
alias ':qa'="pkill urxvt"

# Shortcuts
alias vim="nvim"
alias dotdrop="$HOME/dotfiles/dotdrop.sh --cfg=~/dotfiles/config.yaml"
alias ytdl="youtube-dl"
alias yt-dl="youtube-dl"
alias rss="newsboat"
alias scim="sc-im"
alias kpass="keepassxc-cli open ~/.keepassxc/Passwords.kdbx"
alias ftmime="xdg-mime query filetype"
alias top="htop"
alias gembrowse="amfora"
alias ncmp="ncmpcpp"
alias mimetype="file --mime-type"
alias rsync="rsync -uv"
alias p="sudo pacman"
alias lf="lfrun"
alias sysctl="sudo systemctl"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gr="git rm"
alias gd="git diff"
alias gb="git branch"
alias gch="git checkout"
alias gc="git commit -S"
alias gcus="git commit"
alias gp="git push"
alias push="git push"

# tmux aliases
alias tn="tmux new"
alias ta="tmux attach"
alias tk="tmux kill-session"
alias tx="tmux kill-server"
alias tls="tmux ls"

# Term-Specific Config
alias ref="source ~/.config/zsh/.zshrc"

# Browsing Aliases
alias cls="clear"
alias lsd="ls -a"
alias lsl="ls -al"
alias browse="lf"
alias navhome="cd ~/"
alias navconf="cd ~/.config"
alias navetc="cd /etc/"
alias cd..="cd .."

# File Manipluation Aliases
alias mkf="touch"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias mkdir="mkdir -p"

# Quick Config Aliases
alias bashrc="$EDITOR ~/.bashrc"
alias zshrc="$EDITOR ~/.config/zsh/.zshrc"
alias xres="$EDITOR ~/.Xresources"
alias bspconf="$EDITOR ~/.config/bspwm/bspwmrc"
alias aweconf="$EDITOR -c ':cd ~/.config/awesome'"
alias scr=$EDITOR -c ':cd ~/.config/scripts'
alias nvimconf="$EDITOR -c ':cd ~/.config/nvim'"
alias roficonf="$EDITOR ~/.config/rofi/config.rasi"
alias neoconf="$EDITOR ~/.config/neofetch/config.conf"

# pacman aliases
alias sysup="sudo pacman -Syu"

# misc aliases
alias vie='nvim $(fzf)'
alias xo='xdg-open $(fzf)'

# Testing Aliases
alias testwm="Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome"
alias nettest="ping theoryware.net"
# }}}

# {{{ functions
ce() {
	find ~/.config -maxdepth 1 -type d | sed "s/\/home\/theorytoe/~/" | fzf --height=50% --layout=reverse --border | sed "s/~/\/home\/theorytoe/" | xargs -r -I {} nvim -c ":cd {}"
}

se() {
	find ~/.config/scripts -type f | sed "s/\/home\/theorytoe/~/" | fzf --height=20 --layout=reverse --border | sed "s/~/\/home\/theorytoe/" | xargs -r -I {} nvim "{}"
}

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

pkg() {
    pkg="$(/bin/paru -Slq | fzf --multi --preview 'paru -Si {1}')"
    if [[ -z "$pkg" ]]; then
        return
    fi
    xargs -a <(echo -n "$pkg") -d"\n" -or paru -S --needed
}

git_branch() {
    if [ -d .git ]; then
        printf "%s" "<$git branch 2> /dev/null | awk '/\*/{print $2}')>"
    fi
}


# Functions
mkscr() {
    touch "$1".sh
    chmod +x "$1".sh
    echo "#!/bin/sh" >"$1".sh
}

transfer() {
    if [ $# -eq 0 ]; then
        echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>" >&2
        return 1
    fi
    if tty -s; then
        file="$1"
        file_name=$(basename "$file")
        if [ ! -e "$file" ]; then
            echo "$file: No such file or directory" >&2
            return 1
        fi
        if [ -d "$file" ]; then
            file_name="$file_name.zip" ,
            (cd "$file" && zip -r -q - .) | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null,
        else cat "$file" | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null; fi
    else
        file_name=$1
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null
    fi
}

t() {
	tmux attach -t $(tmux ls | awk '{print $1}' | sed "s/://g" | fzf --layout=reverse --height=30% --border)
}

qgiph() {
	giph -s -d 3 --verbose "$1.mp4"
}

session() {
    tmux new -s "$1"
}

sessions() {
    tmux ls
}

attach() {
    tmux attach -t "$1"
}
restore() {
    tmux attach -t "$1"
}
# }}}

# {{{ snag plugins
source ~/repos/snag/snag.zsh

snag-use "zdharma/fast-syntax-highlighting"
snag-use "zsh-users/zsh-autosuggestions"
snag-use "ael-code/zsh-colored-man-pages" "colored-man-pages"
snag-use "joshskidmore/zsh-fzf-history-search"
snag-use "aloxaf/fzf-tab"
snag-use "chipsenkbeil/zsh-notes"
snag-use "urbainvaes/fzf-marks"
snag-use "nullsense/fuzzy-sys"

# snag-use "zsh-users/zsh-syntax-highlighting"
# }}}

if [ "$TERM" = "screen-256color" ]; then
    :
else
    neofetch
	# mafetch
fi

alias luamake=/home/theorytoe/repos/lua-language-server/3rd/luamake/luamake

