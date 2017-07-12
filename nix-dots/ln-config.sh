#!/bin/sh

nix-env -f i3-config.nix -i
ln -fs "$(nix-env -q i3Config --out-path --no-name)" /home/dtheriault3/.i3/config

nix-env -f latexmk-config.nix -i
ln -fs "$(nix-env -q LatexMk --out-path --no-name)" /home/dtheriault3/.latexmkrc

