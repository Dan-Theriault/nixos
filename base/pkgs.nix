# CLI utilities, services, and other packages that should always be installed.

{ config, pkgs, ... }:

{
  environment.systemPackages = ( with pkgs; [
    wget curl
    htop ncdu
    git
    ag
    taskwarrior timewarrior # bugwarrior
    tree
    nix-repl
    netsniff-ng
    wireshark-cli
  ] );
}
