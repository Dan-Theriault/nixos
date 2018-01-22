{ config, pkgs, ... }:

let
  # unstable = import <unstable> { config = config.nixpkgs.config; };
  # unwrapped = unstable.firefox-devedition-bin-unwrapped;
  # name = unwrapped.name;

  # firefox-custom = unstable.wrapFirefox unwrapped {
  #   browserName = "firefox-devedition";
  #   desktopName = "Firefox Developer Edition";
  #   extraNativeMessagingHosts = [ pkgs.keepassx-community ];
  #   inherit name;
  # };
  firefox-custom = pkgs.buildEnv {
    name = "firefox-custom";
    paths = [ 
      pkgs.firefox
      pkgs.keepassx-community 
      pkgs.ffmpeg pkgs.libav
    ];
  };
in
{
  nixpkgs.config = {
    allowUnfree = true;
    firefox = {
      # enableMPlayer = true;
      ffmpegSupport = true;
      gtk3Support = true;
    };
  };

  environment.systemPackages =  with pkgs; [
    arandr
    chromium
    inkscape
    libav
    libreoffice-fresh detox
    mpv youtube-dl
    sc-im
    steam
    steam-run
    wireshark
    xst
    zathura
  ] ++ ( with pkgs.kdeApplications; [
      okular
      filelight
      dolphin
      kate
      kgpg
  ] ) ++ [
    firefox-custom 
  ];
}
