#!/bin/sh
# Load resources for login

# start with a clean background
xsetroot -gray

# Set up a nice background if it exists
if [ -e .background ]; then
    if command -v display > /dev/null 2>&1; then
        display -antialias -backdrop -window root .background
    fi
fi

# Start screensaver
if command -v xscreensaver > /dev/null 2>&1; then
    xscreensaver -no-splash &
fi

#Activate xmodmap
if command -v xmodmap > /dev/null 2>&1; then
    xmodmap ~/.Xmodmap
fi

#Start up pulse if we have it
if command -v pulseaudio > /dev/null 2>&1; then
    pulseaudio --start
fi

# My Laptop stuff
if [ $HOSTNAME = "centurion" ]; then
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
