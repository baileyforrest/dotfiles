#!/bin/bash

# Set XDG_CONFIG_HOME if its not set yet
[[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME="$HOME/.config"

[[ -z $LOCAL_PREFIX ]] && export LOCAL_PREFIX="$HOME/local"

export EDITOR="emacs -nw"
export BROWSER=chromium


# Colorized ls
if [[ -r $XDG_CONFIG_HOME/shell/dircolors ]] && type -p dircolors > /dev/null; then
    eval $(dircolors -b "$XDG_CONFIG_HOME/shell/dircolors")
fi


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


export PATH="$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"

# Disable x11-ssh-askpass
unset SSH_ASKPASS
