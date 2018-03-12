# CLI utilities, services, and other packages that should always be installed.

{ config, pkgs, ... }:

{
  environment.systemPackages = ( with pkgs; [ 
    dnsutils
    git
    gnupg
    htop ncdu
    neofetch
    netsniff-ng
    nix-prefetch-scripts
    psmisc # killall and friends
    taskwarrior timewarrior python36Packages.bugwarrior
    tree
    unzip
    vim
    wget curl
    whois
  ] );
}
