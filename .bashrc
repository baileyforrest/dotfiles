# .bashrc
# Bailey Forrest <baileycforrest@gmail.com>

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[0;32m\]\u \[\033[1;31m\]\W $\[\033[0m\] '

# Source common configuration options
common=$XDG_CONFIG_HOME/shell/common
test -r $common && . $common
unset common
