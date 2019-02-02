{ config, pkgs,
  tex ? false,
  bluej ? false,
  
}:

with pkgs; [
  antimony gmsh # weird CAD and a STL viewer.
  arandr
  inkscape
  libav
  libqalculate
  libreoffice-fresh detox
  kdenlive
  mpv youtube-dl
  meld # graphical diffs
  sc-im
  wireshark
  xst
  zathura

  ( wrapFirefox firefox-devedition-bin-unwrapped {
    browserName = "firefox";
  })
  keepassxc
] ++ ( with pkgs.kdeApplications; [
  okular
  filelight
  dolphin
  kate
  kgpg
  spectacle
] ) ++ ( if !bluej then [] else
  import ../desktop/bluej.nix {inherit config pkgs;}
) ++ (if !tex then [] else
  import ../desktop/tex.nix {inherit config pkgs;}
)
