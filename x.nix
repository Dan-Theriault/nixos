# Graphical User Environment Configuration

{ config, pkgs, ... }:

{
  boot.plymouth = {
    themePackages = [ pkgs.plasma5.breeze-plymouth ];
  };

  services.xserver = { 
    enable = true;
    layout = "us";
    xkbOptions = "compose:ralt, caps:escape"; # may not work as expected in vm

    displayManager.sddm = {
      enable = true;
      autoLogin.user = "dtheriault3";
      # package = pkgs.sddmPlasma5;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  services.redshift = {
    enable = true;
    latitude = "33";
    longitude = "-84";
  };

  # services.compton = { # disable on vm without graphics card emulation
  #   enable = true;
  #   backend = "glx";
  #   vSync = "opengl";
  #   inactiveOpacity = "0.92";
  #   shadow = true;
  #   extraOptions = ''
  #     paint-on-overlay = true;
  #     blur-background = true;
  #     glx-no-stencil = true;
  #   '';
  # };

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
    firefox-beta-bin keepassx-community
    chromium
    steam
  ] ) );
}
