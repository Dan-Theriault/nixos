# Graphical User Environment Configuration

{ config, pkgs, ... }:

{
  console.useXkbConfig = true;
  services.gnome.at-spi2-core.enable = true;
  sound.enable = true;

  environment.systemPackages = with pkgs; [
    playerctl
    arc-icon-theme arc-theme moka-icon-theme # Themes
    gnome3.dconf
  ];

  programs.light.enable = true; # backlight control pkg + setuid wrapper
  programs.dconf.enable = true;
  programs.qt5ct.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ]; # shouldn't be necessary after 18.09
}
