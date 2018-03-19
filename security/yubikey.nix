{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    yubikey-personalization
    yubikey-manager

    ccid
    pcsclite pcsctools
  ];

  services = {
    udev.packages = with pkgs; [ yubikey-personalization ];
    pcscd.enable = true;
  };
}
