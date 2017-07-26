# Basic Networking configuration

{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    # tcpcrypt.enable = true;
  };

  services = {
    # Secure & Cached DNS
    dnscrypt-proxy = {
      enable =true;
      localPort = 43;
    };
    dnsmasq = {
      enable = true;
      servers = [ "127.0.0.1#43" ];
      extraConfig =  ''
        address=/lipa.ms.mff.cuni.cz/146.185.144.154
      '';
    };

    # Secure serverless sync
    syncthing = {
      enable = true;
      useInotify = true;
      openDefaultPorts = true;
    };

    # TODO: Firewall
    # TODO: openVPN
    # TODO: ssh
  };
}
