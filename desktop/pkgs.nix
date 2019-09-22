{ config, pkgs,
  tex ? false,
}:

with pkgs; [
  anbox
  antimony gmsh # weird CAD and a STL viewer.
  inkscape
  libav
  libnotify
  libqalculate
  libreoffice-fresh detox
  kdenlive
  mpv youtube-dl
  # meld # graphical diffs
  sc-im
  wireshark
  zathura
  firefox-wayland
#   ( wrapFirefox firefox-devedition-bin-unwrapped {
#     browserName = "firefox";
#     gdkWayland = true;
#     # extraNativeMessagingHosts = [ keepassxc ];
#   })
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
