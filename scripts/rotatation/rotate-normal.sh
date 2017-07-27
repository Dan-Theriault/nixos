#!/usr/bin/env bash

xrandr --auto --output eDP-1 --rotate normal --mode 1920x1080
xrandr -o normal
xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' 1, 0, 0, 0, 1, 0, 0, 0, 1 || xinput set-prop 'ELAN Touchscreen Pen' 'Coordinate Transformation Matrix' 1, 0, 0, 0, 1, 0, 0, 0, 1
xinput set-prop 'ELAN Touchscreen Pen Pen (0)' 'Coordinate Transformation Matrix' 1, 0, 0, 0, 1, 0, 0, 0, 1
killall polybar
polybar main &
killall onboard
xinput enable 'SynPS/2 Synaptics TouchPad'
