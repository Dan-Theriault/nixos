{ config, pkgs, ... }:

{

  nixpkgs.config.packageOverrides = pkgs: {
    keepassx-community = pkgs.keepassx-community.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "varjolintu";
        repo = "keepassxc";
        rev = "2.2.4-browser-rc7";
        sha256 = "0ng0mnxipmxzhf2bbf5ddbb50npkx230pk0l3xll3jv60m3kcx24";
      };
    } );
  };

  environment.systemPackages = ( pkgs.lib.flatten ( with pkgs; [
    #######
    ### GUI Programs
    #########
    arandr
    gnome3.gnome-font-viewer
    libreoffice-fresh
    mpv youtube-dl
    wireshark
    zathura
    xst

    ( with kdeApplications; [
      okular
      filelight
      dolphin
      kate
      kgpg
    ] )


    # TODO: Containerize applications with large attack surfaces
    firefox-bin 
    firefox-devedition-bin
    keepassx-community
    # chromium
    steam

  ] ) );
}
