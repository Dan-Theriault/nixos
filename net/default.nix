# Basic Networking configuration

{ config, pkgs, ... }:

{
  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    resolvconf.enable = false;
    dhcpcd.extraConfig = ''
      nohook resolv.conf
    '';

    # useNetworkd = true;
    # useDHCP = false;

    firewall.allowPing = true;
    firewall.allowedTCPPorts = [ 53 ];
  };
  
  services = {
    tailscale.enable = true;

    resolved = {
      enable = true;
      dnssec = "true";
      fallbackDns = [ "127.0.0.1" ];
    };

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
            forward-addr = [ "127.0.0.1@8053" "::1@8053" ];
          }
        ];
      };
    };
  };
}
