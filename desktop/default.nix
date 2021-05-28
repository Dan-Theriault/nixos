# Graphical User Environment Configuration

{ config, pkgs, ... }:

{
  services.gnome.at-spi2-core.enable = true;
  sound.enable = true;

  environment.systemPackages = with pkgs; [
    playerctl
  ];

  programs.light.enable = true; # backlight control pkg + setuid wrapper
  programs.qt5ct.enable = true;
}
