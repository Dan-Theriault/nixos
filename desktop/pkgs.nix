{ config, pkgs, ... }:

{
  environment.systemPackages = ( pkgs.lib.flatten ( with pkgs; [
    #######
    ### GUI Programs
    #########
    arandr
    gnome3.gnome-font-viewer
    libreoffice-fresh
    mpv youtube-dl
    python27Packages.syncthing-gtk
    termite
    wireshark
    zathura

    ( with kdeApplications; [
      okular
      filelight
      dolphin
      kate
      kgpg
    ] )


    # TODO: Containerize applications with large attack surfaces
    firefox-beta-bin keepassx-community
    # chromium
    steam

  ] ) );
}
