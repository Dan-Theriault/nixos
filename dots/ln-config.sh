#!/bin/sh

PREFIX='/etc/nixos/dots'

nix-env -f "$PREFIX/i3-config.nix" -i
ln -fs "$(nix-env -q i3Config --out-path --no-name)" /home/dtheriault3/.i3/config

nix-env -f "$PREFIX/latexmk-config.nix" -i
ln -fs "$(nix-env -q LatexMk --out-path --no-name)" /home/dtheriault3/.latexmkrc

nix-env -f "$PREFIX/polybar-config.nix" -i
ln -fs "$(nix-env -q PolybarConfig --out-path --no-name)" /home/dtheriault3/.config/polybar/config

nix-env -f "$PREFIX/termite-config.nix" -i
ln -fs "$(nix-env -q TermiteConfig --out-path --no-name)" /home/dtheriault3/.config/termite/config
nix-env -f "$PREFIX/gtk-css.nix" -i
ln -fs "$(nix-env -q gtkcssConfig --out-path --no-name)" /home/dtheriault3/.config/gtk-3.0/gtk.css

