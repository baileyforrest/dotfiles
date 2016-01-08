# .zshrc
# Bailey Forrest <baileycforrest@gmail.com>

ZDOTDIR=$XDG_CONFIG_HOME/zsh

# History
HISTFILE=$ZDOTDIR/histfile
HISTSIZE=100000
SAVEHIST=100000

bindkey -e # Emacs key binds
autoload -Uz compinit; compinit # Enable auto completion

# Word select similar to bash. e.g. meta-backspace deletes one directory.
autoload -U select-word-style; select-word-style bash

# Prompt
autoload -U colors zsh/terminfo; colors # Colors and terminfo for prompt
PROMPT="%{$fg[green]%}%n%  %{$fg_no_bold[red]%}%1~ %{$fg[cyan]%}%# %{$reset_color%}"
RPROMPT="[%{$fg[magenta]%}%T %{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# Source common configuration options
common=$XDG_CONFIG_HOME/shell/common
test -r $common && . $common
unset common
