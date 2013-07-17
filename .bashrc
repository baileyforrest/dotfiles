#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

PS1='\[\033[0;32m\]\u \[\033[1;31m\]\W/\[\033[0m\] '

alias emacs="emacs -nw"
alias suemacs="sudo emacs -nw"
alias ..='cd ..'
export WINEARCH="win32"
export EDITOR="emacs -nw"
export PATH="$PATH:~/scripts"
