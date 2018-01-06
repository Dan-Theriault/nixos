# Basic Networking configuration

{ config, pkgs, ... }:

{
  networking = {
    # networkmanager.enable = true;
    firewall.allowPing = true;
  };

  services = {
    # Secure & Cached DNS
    dnscrypt-proxy = {
      enable = true;
      localPort = 43;
      # resolverName = "dnscrypt.ca-1";
    };
    dnsmasq = {
      enable = true;
      servers = [ "127.0.0.1#43" ];
      extraConfig =  ''
        address=/lipa.ms.mff.cuni.cz/146.185.144.154
        interface=lo
        no-resolv
      '';
    };

    # Secure serverless sync
    syncthing = {
      enable = true;
      openDefaultPorts = true;
    };

    # TODO: Firewall
    # TODO: wireguard
    # TODO: better backup / sync solution?
    # - Rsyncd not really intended for this
    # - syncthing is non-declarative
    # - resilio is not FOSS
    # - lsyncd, unison, etc. not packaged for NixOs <--- surmountable
    # - tahoe is complicated AF
  };
}
