# Graphical User Environment Configuration

{ config, pkgs, ... }:

{
  services.xserver = { 
    enable = true;
    layout = "us";
    xkbOptions = "compose:ralt, caps:escape"; # may not work as expected in vm

    desktopManager.plasma5.enable = true;

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      configFile = pkgs.lib.mkDefault (pkgs.writeTextFile {
        name = "i3.conf";
        text = import ../desktop/i3.nix { inherit config pkgs; };
      });
    };
  };

  services.gnome3.at-spi2-core.enable = true;
  sound.enable = true;

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
    xorg.xbacklight 
    xdotool 
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
    qt5ct libsForQt5.qtstyleplugins lxappearance       # and programs to set them

  ] ) );

  programs.light.enable = true; # backlight control pkg + setuid wrapper
}
