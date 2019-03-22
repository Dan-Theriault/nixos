#! /usr/bin/env nix-shell
#! nix-shell <nixpkgs> -i bash -p jq

NUM=$(swaymsg -t get_outputs | jq .[0].scale)
NEW=$((1 + (NUM % 2)))

swaymsg "output * scale $NEW"
