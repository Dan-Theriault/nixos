#!/usr/bin/env fish

/run/current-system/sw/bin/playerctl pause
/run/current-system/sw/bin/i3lock-fancy -f Overpass-Black -t "TYPE TO UNLOCK" -- maim; 
/run/current-system/sw/bin/systemctl restart openvpn-mullvad-main
