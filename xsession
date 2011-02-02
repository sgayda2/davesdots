#!/bin/sh
# Load resources for login

# start with a clean background
xsetroot -gray

# Set up a nice background if it exists
[ -e .background ] && command -v display > /dev/null 2>&1 && display -antialias -backdrop -window root .background

# Bind keys the way I like em
command -v xbindkeys > /dev/null 2>&1 && xbindkeys

# Start screensaver
command -v xscreensaver > /dev/null 2>&1 && xscreensaver -no-splash &

#Activate xmodmap
command -v xmodmap > /dev/null 2>&1 && xmodmap ~/.Xmodmap

#Start up pulse if we have it
command -v pulseaudio > /dev/null 2>&1 && pulseaudio --start

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
