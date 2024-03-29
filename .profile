#!/bin/bash

# Set XDG variables if not set
[[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME="$HOME/.config"
[[ -z $XDG_CACHE_HOME ]] && export XDG_CACHE_HOME="$HOME/.cache"
[[ -z $XDG_DATA_HOME ]] && export XDG_DATA_HOME="$HOME/.local/share"

[[ -z $LOCAL_PREFIX ]] && export LOCAL_PREFIX="$HOME/local"

# Variables
export EDITOR=vim
export BROWSER=google-chrome-stable
export HISTTIMEFORMAT="[%F %T %z] "

# FZF options
export FZF_DEFAULT_COMMAND='rg --files --color never'
export FZF_DEFAULT_OPTS="--tiebreak=length,end"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_TMUX_OPTS="-d 40%"

# Find ruby gem path
if which ruby > /dev/null && which gem > /dev/null; then
    PATH="$PATH:$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
fi

PATH="$LOCAL_PREFIX/bin:$PATH"
LD_LIBRARY_PATH="$LOCAL_PREFIX/lib:$LD_LIBRARY_PATH"

PATH="$PATH:/sbin/"
PATH="$PATH:$HOME/.dotfiles/scripts"
PATH="$HOME/.depot_tools:$PATH"
PATH="$PATH:/usr/local/go/bin"
PATH="$HOME/.cabal/bin:$PATH"
PATH="$PATH:$HOME/.cargo/bin"

load_nvm() {
    export NVM_DIR="$XDG_CONFIG_HOME"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

export PATH
PATH="$("$HOME/.dotfiles/clean_path" "$PATH")"
export LD_LIBRARY_PATH
LD_LIBRARY_PATH="$("$HOME/.dotfiles/clean_path" "$LD_LIBRARY_PATH")"

# Disable x11-ssh-askpass
unset SSH_ASKPASS
