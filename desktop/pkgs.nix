{ config, pkgs, ... }:

{
  nixpkgs.config.overridePackges = {
    kdenlive = pkgs.kdenlive.override {
      buildInputs = [ pkgs.frei0r ];
    };
  };

  environment.systemPackages =  with pkgs; [
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
  ] );
}
