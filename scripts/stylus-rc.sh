#!/bin/bash

# Find the input device number.
devicename="ELAN Touchscreen Pen"
numevents=$(find /dev/input -name "event*" | wc -l)
for ((devnr=0;devnr<numevents;devnr++)); do
    input-kbd $devnr | grep -q "$devicename"
    if [[ $? == 0 ]]; then
        break
    fi
done

# Listen for BTN_TOOL_RUBBER events.
evtest /dev/input/event$devnr | while read -r line; do
for value in {0..1}; do
    echo "$line"|grep -q "type 1 (EV_KEY), code 321 (BTN_TOOL_RUBBER), value $value"
    if [[ $? == 0 ]]; then
        case $value in
            0)  xdotool mouseup 3   ;;
            1)  xdotool mousedown 3 ;;
        esac
    fi
done
done