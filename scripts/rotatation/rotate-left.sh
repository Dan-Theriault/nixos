#!/usr/bin/env bash

xrandr --auto --output eDP-1 --rotate left
xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' 0, -1, 1, 1, 0, 0, 0, 0, 1 || xinput set-prop 'ELAN Touchscreen Pen' 'Coordinate Transformation Matrix' 0, -1, 1, 1, 0, 0, 0, 0, 1
xinput set-prop 'ELAN Touchscreen Pen Pen (0)' 'Coordinate Transformation Matrix' 0, -1, 1, 1, 0, 0, 0, 0, 1
killall polybar
polybar main &
onboard &
xinput disable 'SynPS/2 Synaptics TouchPad'
