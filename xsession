#!/bin/sh
# Load resources for boot

# Check for .background
if [ -n .background ]; then
    if [ -x /usr/bin/display ]; then
        display -antialias -backdrop -window root .background
    elif [ -x /usr/bin/xli ]; then
        xli -onroot -quiet -fillscreen .background
    else
        xsetroot -gray
    fi
else
    xsetroot -gray
fi

# Bind keys the way I like em
[ -x /usr/bin/xbindkeys ] && /usr/bin/xbindkeys

# Start screensaver
if [ -x /usr/bin/gnome-screensaver ]; then
    gnome-screensaver
elif [ -x /usr/bin/xscreensaver ]; then
    xscreensaver -no-splash &
fi

#Activate xmodmap
xmodmap ~/.Xmodmap

# My Laptop stuff
if [ ${USER} = "azakus" ]; then
    trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --height 10 --transparent true --tint 0x000000 &
    nm-applet &
    blueman-applet &
    pidgin &
    xfce4-volumed
    dropbox &
    toggle_touchpad
fi

# Start xmonad
exec xmonad
