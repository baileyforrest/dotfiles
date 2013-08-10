# .zshrc

zstyle :compinstall filename '/home/bcforres/.zshrc'

autoload -Uz compinit
compinit
bindkey -e
ZDOTDIR=~/.zsh
autoload -U select-word-style
select-word-style bash
stty -ixon

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Variables
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
PROMPT="%{$fg[green]%}%n%  %{$fg_no_bold[red]%}%1~ %{$fg[cyan]%}%# %{$reset_color%}"
RPROMPT="[%{$fg[magenta]%}%T %{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

export BROWSER="chromium --allow-file-access-from-files"
export EDITOR=vim

alias ls='ls --color=auto'

alias usbmount="sudo mount -o gid=users,fmask=113,dmask=002"
alias suvim="sudo vim"
alias ..='cd ..'

alias sshshark="ssh bcforres@shark.ics.cs.cmu.edu"
alias sshandrew="ssh bcforres@unix.andrew.cmu.edu"
alias sshYshark="ssh -Y bcforres@shark.ics.cs.cmu.edu"
alias sshYandrew="ssh -Y bcforres@unix.andrew.cmu.edu"
alias sshece="ssh bcforres@ece000.ece.cmu.edu"
alias sshYece="ssh -Y bcforres@ece000.ece.cmu.edu"

#Window title
#case $TERM in
#    termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
#        precmd () { print -Pn "\e]0;%n@%M %~ %#\a" }
#        preexec () { print -Pn "\e]0;%n@%M %~ %# [$1]\a" }
#        ;;
#    screen|screen-256color)
#        precmd () {
#            print -Pn "\e]83;title \"$1\"\a"
#            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
#        }
#        preexec () {
#            print -Pn "\e]83;title \"$1\"\a"
#            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
#        }
#        ;;
#esac

#colorized man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

