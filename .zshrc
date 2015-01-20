# .zshrc

zstyle :compinstall filename '/home/bcforres/.zshrc'

# Enable auto completion
autoload -Uz compinit
compinit

# Emacs key binds
bindkey -e

ZDOTDIR=~/.zsh

# Word select similar to bash
autoload -U select-word-style
select-word-style bash
stty -ixon

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Variables
autoload -U colors zsh/terminfo # Used in the color alias below
colors
PROMPT="%{$fg[green]%}%n%  %{$fg_no_bold[red]%}%1~ %{$fg[cyan]%}%# %{$reset_color%}"
RPROMPT="[%{$fg[magenta]%}%T %{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# Load configuration files
for config in .aliases .funcs; do
    [[ -r $HOME/.config/$config ]] && . "$HOME/.config/$config"
done
unset config

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
