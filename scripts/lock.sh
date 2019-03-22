#! /usr/bin/env nix-shell
#! nix-shell <nixpkgs> -i bash -p swaylock imagemagick grim

IMAGE=/tmp/swaylock.png

grim -g "0,0 1920x1080" -o "*" $IMAGE
convert $IMAGE -blur "10x10" $IMAGE
convert $IMAGE /etc/nixos/scripts/resources/lock.png -gravity center -composite $IMAGE
swaylock -i $IMAGE
rm $IMAGE
