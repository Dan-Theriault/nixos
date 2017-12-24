# CLI utilities, services, and other packages that should always be installed.

{ config, pkgs, ... }:

{
  environment.systemPackages = ( with pkgs; [
    wget curl
    vim
    htop ncdu
    git
    ag
    neofetch
    taskwarrior timewarrior # bugwarrior
    tree
    nix-repl
    netsniff-ng
    psmisc # killall and friends
    gnupg
    dnsutils
    nix-prefetch-scripts
    unzip
    telnet
    whois
  ] );
}
