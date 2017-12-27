{ config, pkgs, ... }:

let
  unstable = import <unstable> { config = config.nixpkgs.config; };
  unwrapped = unstable.firefox-devedition-bin;
  name = unwrapped.name;

  # firefox-custom = unstable.wrapFirefox unwrapped {
  #   browserName = "firefox-devedition";
  #   desktopName = "Firefox Developer Edition";
  #   extraNativeMessagingHosts = [ pkgs.keepassx-community ];
  #   inherit name;
  # };
  firefox-custom = pkgs.buildEnv {
    name = "firefox-custom";
    paths = [ pkgs.firefox-devedition-bin pkgs.keepassx-community ];
  };
in
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      keepassx-community = pkgs.keepassx-community.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "varjolintu";
          repo = "keepassxc";
          rev = "2.2.4-browser-rc7";
          sha256 = "0ng0mnxipmxzhf2bbf5ddbb50npkx230pk0l3xll3jv60m3kcx24";
        };
      } );
    };
    allowUnfree = true;
  };

  environment.systemPackages =  with pkgs; [
    arandr
    gnome3.gnome-font-viewer
    libreoffice-fresh
    mpv youtube-dl
    wireshark
    zathura
    xst

    steam
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
