#!/bin/sh
# Load resources for boot

# Set up a nice background

if [ -e .background ]; then
    if command -v display; then
        display -antialias -backdrop -window root .background
    else
        xsetroot -gray
    fi
else
    xsetroot -gray
fi

# Bind keys the way I like em
command -v xbindkeys > /dev/null 2>&1 && xbindkeys

# Start screensaver
command -v xscreensaver > /dev/null 2>&1 && xscreensaver -no-splash &

#Activate xmodmap
command -v xmodmap > /dev/null 2>&1 && xmodmap ~/.Xmodmap

# My Laptop stuff
if [ ${USER} = "azakus" ]; then
    trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --height 10 --transparent true --tint 0x000000 &
    nm-applet &
    blueman-applet &
    pidgin &
    dropbox &
    xfce4-volumed
    ~/bin/toggle_touchpad
fi

# Start xmonad
exec xmonad
