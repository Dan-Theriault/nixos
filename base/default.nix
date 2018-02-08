# Base system with editor and major shell utilities

{ config, pkgs, ... }:

{
  imports = [
    ../base/base-net.nix
    ../base/users.nix
    ../base/pkgs.nix
  ];

  # Nix settings
  nix = {
    gc.automatic = true;
    useSandbox = true;
  };
  nixpkgs.config.allowUnfree = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";
  services.openntpd.enable = true;
  boot.kernelPackages = pkgs.lib.mkDefault pkgs.linuxPackages_latest;

  # Manual on VT-8
 services.nixosManual.showManual = true;

  # Version
  system.stateVersion = "17.09";
}
