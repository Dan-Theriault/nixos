# Basic Networking configuration

{ config, pkgs, ... }:

{
  networking = {
    firewall.allowPing = true;
    defaultMailServer = {
      directDelivery = true;
      domain = "theriault.codes";
      hostName = "smtp.fastmail.com:465";
      authUser = "dan@theriault.codes";
      authPassFile = "/etc/secrets/mail";
      useTLS = true;
    };
  };
  
  systemd.services = {
    "nixos-upgrade".onFailure = [ "notify-email@%i.service" ];
    "notify-email@" = {
      description = "Send an email with service status";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''/bin/sh -c '${pkgs.systemd}/bin/systemctl status %i | ${pkgs.mailutils}/bin/mail -s "[%i] Failure" dan@theriault.codes' '';
      };
    };
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
      '';
    };

    # Secure serverless sync
    syncthing = {
      enable = pkgs.lib.mkDefault true;
      openDefaultPorts = true;
      user = "dtheriault3";
      group = "users";
      dataDir = "/home/dtheriault3/.syncthing";
    };
  };
}
