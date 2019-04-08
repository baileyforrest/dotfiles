# .bashrc
# Bailey Forrest <baileycforrest@gmail.com>

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[0;32m\]\W \[\033[1;31m\]$\[\033[0m\] '

# Unlimited history size
HISTSIZE=
HISTFILESIZE=
shopt -s histappend # Append to history rather than overwriting.

# Source common configuration options
[ -f $XDG_CONFIG_HOME/shell/common ] && source $XDG_CONFIG_HOME/shell/common

# Enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# Load bash specific files
if [ -n "$(ls $XDG_CONFIG_HOME/shell/bash/ 2>/dev/null)" ]; then
  for config in $XDG_CONFIG_HOME/shell/bash/*; do
      . $config
  done
  unset config
fi

# Enable fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
