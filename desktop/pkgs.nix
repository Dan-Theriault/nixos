{ config, pkgs, ... }:

let
  mozilla = builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
  firefox-custom = pkgs.buildEnv {
    name = "firefox-custom";
    paths = [ 
      # pkgs.latest.firefox-beta-bin
      pkgs.firefox-beta-bin
      pkgs.ffmpeg pkgs.libav
      pkgs.keepassxc
    ];
  };
in
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
  ] ++ ( with pkgs.kdeApplications; [
      okular
      filelight
      dolphin
      kate
      kgpg
      spectacle
  ] ) ++ [
    firefox-custom 
    firefoxPackages.tor-browser
  ];
}
