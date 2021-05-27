# Basic Networking configuration

{ config, pkgs, ... }:

{
  networking = {
    firewall.allowPing = true;
  };
  
  services = {
    stubby = {
      enable = true;
      listenAddresses = [ "127.0.0.1@8053" "0::1@8053" ];
    };
    unbound = {
      enable = true;
      settings = {
        server = {
          access-control = ''
            127.0.0.1/8 allow
          '';
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
