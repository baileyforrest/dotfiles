# .zshrc

zstyle :compinstall filename '/home/bcforres/.zshrc'

autoload -Uz compinit
compinit
bindkey -e
ZDOTDIR=~/.zsh
autoload -U select-word-style
select-word-style bash
stty -ixon

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Variables
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
PROMPT="%{$fg[green]%}%n%  %{$fg_no_bold[red]%}%1~ %{$fg[cyan]%}%# %{$reset_color%}"
RPROMPT="[%{$fg[magenta]%}%T %{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

export BROWSER="chromium --allow-file-access-from-files"
export EDITOR=vim

# Aliases
alias ls='ls --color=auto'
alias usbmount='sudo mount -o gid=users,fmask=113,dmask=002'
alias suvim='sudo vim'
alias ..='cd ..'
alias detach='sudo udisks --detach'

# Disable x11-ssh-askpass
unset SSH_ASKPASS

#colorized man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# Marking directories
export MARKPATH=$HOME/.marks
function jump {
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}

function mark {
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}

function unmark {
    rm -if $MARKPATH/$1
}

function marks {
    \ls -l $MARKPATH | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}

function _marks {
    reply=($(ls $MARKPATH))
}

compctl -K _marks jump
compctl -K _marks unmark
