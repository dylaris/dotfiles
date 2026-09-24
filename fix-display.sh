#!/bin/bash
export DISPLAY=:0
export XAUTHORITY=/home/dylaris/.Xauthority

case $1 in
    pre)
        xrandr --output DP-1 --off
        ;;
    post)
        sleep 2
        xrandr --output DP-1 --off
        sleep 1
        xrandr --output DP-1 --auto --right-of eDP-1
        ;;
esac
