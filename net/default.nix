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
      allowedAccess = [ "127.0.0.1/24" ];
      extraConfig = ''
        hide-identity: yes
        hide-version: yes
        qname-minimisation: yes
        harden-short-bufsize: yes
        harden-large-queries: yes
        harden-glue: yes
        harden-dnssec-stripped: yes
        harden-below-nxdomain: yes
        harden-referral-path: yes
        do-not-query-localhost: no
        forward-zone:
          name: "."
            forward-addr: 127.0.0.1@8053
            forward-addr: ::1@8053
      '';
    };
  };
}
