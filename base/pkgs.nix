# CLI utilities, services, and other packages that should always be installed.

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    abduco # detached sessions
    dnsutils
    git
    gnupg
    htop ncdu
    mailutils
    neofetch
    netsniff-ng # flowtop, others
    nix-prefetch-scripts # is this necessary with 2.0?
    psmisc # killall and friends
    taskwarrior timewarrior python36Packages.bugwarrior
    tree
    unzip
    vim
    wget curl
    whois
  ];
}
