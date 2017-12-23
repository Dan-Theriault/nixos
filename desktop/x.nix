# Graphical User Environment Configuration

{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    polybar = pkgs.polybar.override {
      i3GapsSupport = true;
      mpdSupport = true;
    };
  };
  # environment.sessionVariables = {
  #   "GTK2_RC_FILES" = "/usr/share/themes/Arc-Darker/gtk-2.0";
  #   "GTK_THEME" = "Arc-Darker";
  #   "QT_QPA_PLATFORMTHEME" = "gtk2"; 
  # };

  services.xserver = { 
    enable = true;
    layout = "us";
    xkbOptions = "compose:ralt, caps:escape"; # may not work as expected in vm

    synaptics.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      configFile = /etc/nixos/dots/i3;
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

  # services.compton = { # bad idea with vms or DEs
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
    maim scrot # screenshots

    xlibs.xinput
    xlibs.fontutil
    xdg_utils
    xorg.xkill
    xorg.xhost
    xclip

    arc-icon-theme arc-theme # Themes
    qt5ct lxappearance       # and programs to set them

  ] ) );
}
