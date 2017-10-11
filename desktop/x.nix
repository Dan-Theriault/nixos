# Graphical User Environment Configuration

{ config, pkgs, ... }:

{
  
  nixpkgs.config.packageOverrides = pkgs: {
    polybar = pkgs.polybar.override {
      i3GapsSupport = true;
      mpdSupport = true;
    };
  };

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
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    windowManager.default = "i3";

    desktopManager.xfce = {
      enable = true;
      enableXfwm = false;
      noDesktop = true;
      extraSessionCommands = ''
        xrdb -load /home/dtheriault3/.Xresources
      '';
    };
  };

  services.redshift = {
    enable = true;
    latitude = "33";
    longitude = "-84";
  };

  services.compton = { # disable on vm without graphics card emulation
    enable = true;
    backend = "glx";
    vSync = "opengl";
    inactiveOpacity = "0.92";
    shadow = true;
    extraOptions = ''
      paint-on-overlay = true;
      blur-background = true;
      glx-no-stencil = true;
    '';
  };

  services.gnome3 = {
    evolution-data-server.enable = true;
    gnome-keyring.enable = true;
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
    maim scrot # screenshots

    xlibs.xinput
    xlibs.fontutil
    xdg_utils
    xorg.xkill
    xorg.xhost
    xclip

    xfce.xfce4settings
    xfce.xfconf

    arc-icon-theme arc-theme # themeing

    # libsForQt5.qtstyleplugins 
    # qt5.qtbase
    qt5ct

  ] ) );
}
