# Graphical User Environment Configuration

{ config, pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
  };

  services.xserver = { 
    enable = true;
    layout = "us";
    xkbOptions = "compose:ralt";

    displayManager.sddm = {
      enable = true;
      autoLogin.user = "dtheriault3";
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
    };
  };

  environment.systemPackages = ( pkgs.lib.flatten ( with pkgs; [
    ########
    ### Accessories / Utilities
    ##########
    rofi dmenu # program launchers
    polybar i3lock-fancy # additional interface components
    networkmanagerapplet # applets
    light xdotool playerctl # scriptable settings
    feh # background image

    xlibs.xinput
    xlibs.fontutil
    xdg_utils
    xorg.xkill
    xorg.xhost
    xclip

    arc-icon-theme arc-theme # themeing

    libsForQt5.qtstyleplugins 
    qt5.qtbase

    #######
    ### GUI Programs
    #########
    arandr
    gnome3.gnome-font-viewer
    keepassx-community
    libreoffice-fresh
    python27Packages.syncthing-gtk
    termite
    wireshark
    zathura

    ( with kdeApplications; [
      okular
      filelight
      dolphin
      gwenview
      kate
      kgpg
    ] )


    # TODO: Containerize vulnerable applications
    firefox-beta-bin
    chromium
    steam
  ] ) );
}
