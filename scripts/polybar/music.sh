#!/usr/bin/env bash

if playerctl status > /dev/null; then
    echo "$(playerctl metadata artist) - $(playerctl metadata title)"
else
    mpc current
fi

