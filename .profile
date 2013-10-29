#start mpd and mpdscribble
[ ! -s ~/.mpd/mpd.pid ] && mpd
[ ! -s ~/.mpdscribble/mpdscribble.pid ] && mpdscribble

export PATH="$PATH:/usr/lib/smlnj/bin:/home/bcforres/scripts:/home/bcforres/programming/15410bin"
