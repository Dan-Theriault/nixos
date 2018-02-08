{ config, pkgs, ... }:

{
  imports = [
    ../security/kernel.nix
    ../security/keybase.nix
  ];

  services.haveged.enable = true; # better entropy generation
  networking.tcpcrypt.enable = true; # opportunistic TCP encryption. 

  security = {
    hideProcessInformation = true;
    lockKernelModules = true;
    apparmor.enable = true;
  };

}
