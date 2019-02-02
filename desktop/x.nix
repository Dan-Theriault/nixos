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

    desktopManager.plasma5.enable = true;
    desktopManager.mate.enable = true;

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

  services.redshift = {
    enable = true;
    latitude = "33";
    longitude = "-84";
  };

  services.compton = { # bad idea with vms or DEs
    enable = pkgs.lib.mkDefault true;
    vSync = "opengl";
    backend = "glx";
    # inactiveOpacity = "0.8";
    opacityRules = [
      "85:class_g = 'st-256color'"
    ];
    shadow = true;
    shadowOffsets = [ (-7) (-7) ];
    extraOptions = ''
      paint-on-overlay = true;
      glx-no-stencil = true;

      blur-background = true;
      blur-background-fixed = true;
      blur-kern = "7x7box";

      no-dock-shadow = true;
      no-dnd-shadow = true;
      shadow-radius = 7;
    '';

  };

  environment.systemPackages = ( pkgs.lib.flatten ( with pkgs; [
    rofi dmenu              # program launchers
    i3lock-fancy    # additional interface components
    # polybar
    dunst                   # Notifications
    xss-lock
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
  ] ) );
}
