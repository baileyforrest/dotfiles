#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[0;32m\]\u \[\033[1;31m\]\W/\[\033[0m\] '

for config in .aliases .funcs; do
    [[ -r $HOME/$config ]] && . "$HOME/$config"
done
unset config
