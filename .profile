#!/bin/bash
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
export PATH="$HOME/local/bin:/home/bcforres/.cabal/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/local/lib/:$LD_LIBRARY_PATH"
