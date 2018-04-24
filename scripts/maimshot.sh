#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# A small wrapper for maim which sorts screenshots by program
WM_CLASS=$(xprop WM_CLASS | grep -o '"[^,]*"' | sed 's/"//g' | tail -n 1)
mkdir -p ~/Photos/scrots/"$WM_CLASS"
maim ~/Photos/scrots/"$WM_CLASS"/"$(date +%s).png" # ignore SC, this is correct
