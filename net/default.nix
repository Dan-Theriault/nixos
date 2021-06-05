# Basic Networking configuration

{ config, pkgs, ... }:

{
  networking = {
    nameservers = [ "127.0.0.1" ];
    dhcpcd.extraConfig = "nohook resolv.conf";

    firewall.allowPing = true;
    firewall.allowedTCPPorts = [ 53 ];
  };
  
  # Tailscale configuration
  services.tailscale.enable = true;
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];
  networking.search = [ "theriault.codes.beta.tailscale.net" ];
  boot.kernel.sysctl = { 
    # for exit nodes
    "net.ipv4.conf.all.fowarding" = true;
    "net.ipv6.conf.all.fowarding" = true;
  };
  # there's also the forward zone, below

  services = {
    stubby = {
      enable = true;
      listenAddresses = [ "127.0.0.1@8053" "0::1@8053" ];
    };

    unbound = {
      enable = true;
      settings = {
        server = {
          access-control = [ 
            "127.0.0.1/24 allow"
            "100.64.0.0/10 allow"
          ];
          hide-identity = true;
          hide-version = true;
          qname-minimisation = true;
          harden-short-bufsize = true;
          harden-large-queries = true;
          harden-glue = true;
          harden-dnssec-stripped = true;
          harden-below-nxdomain = true;
          harden-referral-path = true;
          do-not-query-localhost = false;
        };
        forward-zone = [
          {
            name = ".";
            forward-addr = [ 
              "127.0.0.1@8053"
              "::1@8053"
            ];
          }
          {
            name = "theriault.codes.beta.tailscale.net";
            forward-addr = [ "100.100.100.100" ];
          }
        ];
      };
    };
  };
}
