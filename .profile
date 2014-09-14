#!/bin/bash

export EDITOR=vim
export BROWSER=chromium

# Find ruby gem path
if which ruby > /dev/null && which gem > /dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# OPAM configuration
if which opam > /dev/null; then
    . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

# Colorized ls
if [[ -r ~/.dircolors ]] && type -p dircolors > /dev/null; then
    eval $(dircolors -b "$HOME/.dircolors")
fi

export PATH="$HOME/local/bin:/home/bcforres/.cabal/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/local/lib/:$LD_LIBRARY_PATH"

# Disable x11-ssh-askpass
unset SSH_ASKPASS

