#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xset b off

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# exec gnome-session
# exec startkde
exec awesome

#compositing
compton
