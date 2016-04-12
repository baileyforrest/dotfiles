#!/bin/bash

# Set XDG variables if not set
[[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME="$HOME/.config"
[[ -z $XDG_CACHE_HOME ]] && export XDG_CACHE_HOME="$HOME/.cache"
[[ -z $XDG_DATA_HOME ]] && export XDG_DATA_HOME="$HOME/.local/share"

[[ -z $LOCAL_PREFIX ]] && export LOCAL_PREFIX="$HOME/local"

# Variables
export EDITOR=vim
export BROWSER=chromium
export HISTTIMEFORMAT="[%F %T %z] "

# FZF options
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--tiebreak=length,end"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Local prefix
if [ -d "$LOCAL_PREFIX" ]; then
    PATH="$LOCAL_PREFIX/bin:$PATH"
    LD_LIBRARY_PATH="$LOCAL_PREFIX/lib:$LD_LIBRARY_PATH"
fi


# Find ruby gem path
if which ruby > /dev/null && which gem > /dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi


# OPAM configuration
if which opam > /dev/null; then
    . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi


# cabal configuration
if which cabal > /dev/null; then
    PATH="$HOME/.cabal/bin:$PATH"
fi


# depot_tools
if [ -d "$HOME/depot_tools" ]; then
    PATH="$HOME/depot_tools:$PATH"
fi

# golang
if [ -d "/usr/local/go/bin" ]; then
    PATH=$PATH:/usr/local/go/bin
fi

# local bin
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


export PATH="$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"

# Disable x11-ssh-askpass
unset SSH_ASKPASS
