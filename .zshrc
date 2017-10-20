# .zshrc
# Bailey Forrest <baileycforrest@gmail.com>

ZDOTDIR=$XDG_CONFIG_HOME/zsh

# History
HISTFILE=$ZDOTDIR/histfile
HISTSIZE=1000000000
SAVEHIST=1000000000

bindkey -e # Emacs key binds
autoload -Uz compinit; compinit # Enable auto completion

# Word select similar to bash. e.g. meta-backspace deletes one directory.
autoload -U select-word-style; select-word-style bash

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Prompt
autoload -U colors zsh/terminfo; colors # Colors and terminfo for prompt
PROMPT="%{$fg_no_bold[red]%}%1~ %{$fg[cyan]%}%# %{$reset_color%}"
RPROMPT="[%{$fg[magenta]%}%T %{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# Source common configuration options
[ -f $XDG_CONFIG_HOME/shell/common ] && source $XDG_CONFIG_HOME/shell/common

fpath=(~/.zsh $fpath)

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
