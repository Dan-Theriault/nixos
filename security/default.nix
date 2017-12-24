{ config, pkgs, ... }:

{
  services.haveged.enable = true; # better entropy generation
  networking.tcpcrypt.enable = true; # opportunistic TCP encryption. 
}
