{ config, pkgs,
  tex ? false,
}:

with pkgs; [
  # anbox
  # antimony gmsh # weird CAD and a STL viewer.
  inkscape
  libnotify
  libqalculate
  libreoffice-fresh detox
  ffmpeg
  kdenlive
  mpv youtube-dl
  pandoc
  # meld # graphical diffs
  sc-im
  wireshark
  zathura
  firefox-wayland
  keepassxc
] ++ ( with pkgs.kdeApplications; [
  okular
  filelight
  dolphin
  kate
  kgpg
  spectacle
] ) ++ (if !tex then [] else
  import ../desktop/tex.nix {inherit config pkgs;}
)
