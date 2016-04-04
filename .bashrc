# .bashrc
# Bailey Forrest <baileycforrest@gmail.com>

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[0;32m\]\u \[\033[1;31m\]\W $\[\033[0m\] '

# Unlimited history size
HISTSIZE=
HISTFILESIZE=
shopt -s histappend # Append to history rather than overwriting.

# Source common configuration options
common=$XDG_CONFIG_HOME/shell/common
test -r $common && . $common
unset common

# Enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Enable fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
