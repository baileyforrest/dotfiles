#!/bin/bash

# Set XDG variables if not set
[[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME="$HOME/.config"
[[ -z $XDG_CACHE_HOME ]] && export XDG_CACHE_HOME="$HOME/.cache"
[[ -z $XDG_DATA_HOME ]] && export XDG_DATA_HOME="$HOME/.local/share"

[[ -z $LOCAL_PREFIX ]] && export LOCAL_PREFIX="$HOME/local"

# Variables
export EDITOR=vim
export BROWSER=google-chrome
export HISTTIMEFORMAT="[%F %T %z] "

# FZF options
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS="--tiebreak=length,end"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Find ruby gem path
if which ruby > /dev/null && which gem > /dev/null; then
    PATH="$PATH:$(ruby -rubygems -e 'puts Gem.user_dir')/bin"
fi

PATH="$LOCAL_PREFIX/bin:$PATH"
LD_LIBRARY_PATH="$LOCAL_PREFIX/lib:$LD_LIBRARY_PATH"

PATH="$PATH:$HOME/.dotfiles/scripts"
PATH="$PATH:$HOME/depot_tools"
PATH="$PATH:/usr/local/go/bin"
PATH="$PATH:$HOME/.cabal/bin"
PATH="$PATH:$HOME/.cargo/bin"

export PATH="$($HOME/.dotfiles/clean_path $PATH)"
export LD_LIBRARY_PATH="$($HOME/.dotfiles/clean_path $LD_LIBRARY_PATH)"

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi # added by Nix installer

# Disable x11-ssh-askpass
unset SSH_ASKPASS
