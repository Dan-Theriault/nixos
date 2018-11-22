{config, pkgs, ...}:

{
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.99.31.246/32" "fc00:bbbb:bbbb:bb01::1ff6/128" ];
      privateKeyFile = "/etc/secrets/wg";
      # postSetup = ''resolvectl domain wg0 "~."; resolvectl dns wg0 193.138.219.228; resolvectl dnssec wg0 yes'';
      peers = [ {
        publicKey = "AnfOP57FBVtz2qsQmJEANDrbhORJ/e1uHIWhXUd+EUc=";
        allowedIPs = [ "0.0.0.0/0" "::0/0" ];
        endpoint = "193.148.18.210:51820";
      } ];
    };
  };
}
