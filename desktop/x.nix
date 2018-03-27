# Graphical User Environment Configuration

{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    polybar = pkgs.polybar.override {
      i3GapsSupport = true;
      mpdSupport = true;
    };
  };

  services.xserver = { 
    enable = true;
    layout = "us";
    xkbOptions = "compose:ralt, caps:escape"; # may not work as expected in vm

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      configFile = ../dots/i3;
      extraSessionCommands = ''
        xrdb -load /etc/nixos/dots/Xresources
        export QT_QPA_PLATFORMTHEME="qt5ct"
      '';
    };
  };

  services.gnome3.at-spi2-core.enable = true;

  services.redshift = {
    enable = true;
    latitude = "33";
    longitude = "-84";
  };

  services.compton = { # bad idea with vms or DEs
    vSync = "opengl";
    # inactiveOpacity = "1.00";
    extraOptions = ''
      paint-on-overlay = true;
      glx-no-stencil = true;

      opacity-rule = [ "85:class_g = 'st-256color'" ];

      blur-background = true;
      blur-background-fixed = true;
      blur-kern = "7x7box";

      shadow = true;
      no-dock-shadow = true;
      no-dnd-shadow = true;
      shadow-radius = 7;
      shadow-offset-x = -7;
      shadow-offset-y = -7;
    '';
  };

  environment.systemPackages = ( pkgs.lib.flatten ( with pkgs; [
    rofi dmenu              # program launchers
    polybar i3lock-fancy    # additional interface components
    dunst                   # Notifications
    xss-lock
    networkmanagerapplet    # applets
    xorg.xbacklight xdotool playerctl # scriptable settings
    feh                     # background image
    maim scrot              # screenshots

    xlibs.xinput
    xlibs.fontutil
    xdg_utils
    xorg.xkill
    xorg.xhost
    xclip
    xbindkeys

    arc-icon-theme arc-theme moka-icon-theme # Themes
    qt5ct lxappearance       # and programs to set them

  ] ) );
}
