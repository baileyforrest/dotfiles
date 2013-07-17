#
# ~/.bash_profile
#

export PATH="$PATH:~/scripts"
[[ -f ~/.bashrc ]] && . ~/.bashrc

if ps aux | grep -v grep | grep mpdscribble > /dev/null
then
    echo "" > /dev/null
else
    mpdscribble
fi

