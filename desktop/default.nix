# Graphical User Environment Configuration

{ config, pkgs, ... }:

{
  i18n.consoleUseXkbConfig = true;
  services.gnome3.at-spi2-core.enable = true;
  sound.enable = true;

  environment.systemPackages = with pkgs; [
    rofi dmenu              # program launchers
    playerctl

    arc-icon-theme arc-theme moka-icon-theme # Themes
    qt5ct libsForQt5.qtstyleplugins lxappearance       # and programs to set them

    gnome3.dconf
  ];

  programs.light.enable = true; # backlight control pkg + setuid wrapper
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ]; # shouldn't be necessary after 18.09

  virtualisation.anbox = {
    enable = true;
    ipv4.dns = "127.0.0.1";
  };
}
