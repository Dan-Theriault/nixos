# Basic Networking configuration

{ config, pkgs, ... }:
let
  dnscrypt-proxy-2 = pkgs.buildGoPackage rec {
    name = "dnscrypt-proxy-${version}";
    version = "2.0.9";
    rev = "${version}";

    goPackagePath = "github.com/jedisct1/dnscrypt-proxy";

    src = pkgs.fetchgit {
      inherit rev;
      url = "https://github.com/jedisct1/dnscrypt-proxy";
      sha256 = "1qljbk9jhpmbwy14w9ijxaa71nbx6vgagn5bn68l0h4hkyrnakql";
    };

    meta = {
      description = "A flexible DNS proxy, with support for modern encrypted DNS protocols such as DNSCrypt v2 and DNS-over-HTTP.";
      maintainers = with pkgs.stdenv.maintainers; [ dan-theriault ];
      license = pkgs.stdenv.licenses.isc;
      homepage = "https://dnscrypt.info";
      platforms = pkgs.lib.platforms.linux; #
    };
  };
in
{
  networking = {
    # networkmanager.enable = true;
    firewall.allowPing = true;
  };

  environment.systemPackages = [ dnscrypt-proxy-2 ];
  systemd.sockets.dnscrypt-proxy = {
    before = [ "nss-lookup.target" ];
    wants = [ "nss-lookup.target" ];
    socketConfig = {
      ListenStream = "127.0.0.1:43";
      ListenDatagram = "127.0.0.1:43";
      NoDelay = true;
      DeferAcceptSec = 1;
    };
    wantedBy = [ "sockets.target" ];
  };

  systemd.services.dnscrypt-proxy = {
    after = [ "network.target" ];
    before = [ "nss-lookup.target" ];
    wants = [ "nss-lookup.target" ];
    serviceConfig = {
      NonBlocking = true;
      ExecStart = "${dnscrypt-proxy-2}/bin/dnscrypt-proxy --config /etc/dnscrypt-proxy/dnscrypt-proxy.toml";
      ProtectHome="yes";
      ProtectControlGroups="yes";
      ProtectKernelModules="yes";
      DynamicUser="yes";
    };
    bindsTo = [ "dnscrypt-proxy.socket" ];
    wantedBy = [ "dnscrypt-proxy.socket" ];
  };

  services = {
    nscd.enable = false;
    # dnscrypt-proxy = {
    #   enable = true;
    #   localPort = 43;
    # };
    dnsmasq = {
      enable = true;
      # servers = [ "127.0.0.1#43" "1.1.1.1" ];
      servers = [ "127.0.0.1#43" ];
      # servers = [ "193.138.219.228" ];
      # servers = [ "1.1.1.1" ];
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
      user = "dtheriault3";
      group = "users";
      dataDir = "/home/dtheriault3/.syncthing";
    };

    # TODO: Firewall
    # TODO: better backup / sync solution?
    # - Rsyncd not really intended for this
    # - syncthing is non-declarative
    # - resilio is not FOSS
    # - lsyncd, unison, etc. not packaged for NixOs <--- surmountable
    # - tahoe is complicated AF
  };
}
