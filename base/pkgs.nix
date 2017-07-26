# CLI utilities, services, and other packages that should always be installed.

{ config, pkgs, ... }:

{
  environment.systemPackages = ( with pkgs; [
    wget curl
    htop
    git
    ag
    taskwarrior timewarrior
    tree
    nix-repl
    netsniff-ng
    light
    playerctl ncmpcpp cava pamixer
  ] );
}
