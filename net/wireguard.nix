{config, pkgs, ...}:

{
  environment.systemPackages = [ pkgs.wireguard ];
  # boot.kernelModules = [
  #   "ebtables"
  #   "nf_reject_ipv4"
  #   "xt_CHECKSUM"
  # ];

  # networking.interfaces = { wg0 = {}; };
  # networking.wireguard.interfaces = {
  #   wg0 = {
  #     ips = [ "10.0.0.1/24" ];
  #     peers = [ {
  #       allowedIPs = [ "0.0.0.0/0" ];
  #       endpoint = "us1-wireguard.mullvad.net:12913";
  #       publicKey = "Wy2FhqDJcZU03O/D9IUG/U5BL0PLbF06nvsfgIwrmGk=";
  #     } ];
  #     privateKeyFile = "/etc/secrets/wg_id";
  #   };
  # };
}
