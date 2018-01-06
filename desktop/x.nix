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

  services.redshift = {
    enable = true;
    latitude = "33";
    longitude = "-84";
  };

  services.compton = { # bad idea with vms or DEs
    backend = "glx";
    vSync = "opengl";
    inactiveOpacity = "1.00";
    extraOptions = ''
      paint-on-overlay = true;
      glx-no-stencil = true;
    '';
  };

  environment.systemPackages = ( pkgs.lib.flatten ( with pkgs; [
    rofi dmenu              # program launchers
    polybar i3lock-fancy    # additional interface components
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

    arc-icon-theme arc-theme # Themes
    qt5ct lxappearance       # and programs to set them

  ] ) );
}
