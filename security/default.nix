{ config, pkgs, ... }:

{
  imports = [
    ../net/wireguard.nix
    ../security/kernel.nix
    ../security/keybase.nix
    ../security/yubikey.nix
  ];

  services.haveged.enable = true; # better entropy generation
  networking.tcpcrypt.enable = true; # opportunistic TCP encryption. 
  nix.allowedUsers = [ "@wheel" "@builders" ];

  security = {
    hideProcessInformation = true;
    # lockKernelModules = true;
    apparmor.enable = true;
  };

  # boot.kernelModules = [
  #   "ccm"
  #   "ctr"
  # ];

  environment.systemPackages = with pkgs; [
    vulnix
  ];

}
