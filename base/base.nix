# Base system with editor and major shell utilities

{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/base/fish.nix # prompt and aliases
    /etc/nixos/base/net.nix
    /etc/nixos/base/users.nix
    /etc/nixos/base/vim.nix # custom vim with plugins and vimrc
    /etc/nixos/base/pkgs.nix
  ];

  # environment.pathsToLink = [ "/etc/nixos/scripts" ];
  # system.activationScripts = { dots = {
  #   text = builtins.readFile /etc/nixos/dots/ln-config.sh ;
  #   deps = [ pkgs.nix ];
  # }; };

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
  services.ntp.enable = true;

  # Manual on VT-8
 services.nixosManual.showManual = true;

  # Version
  system.stateVersion = "17.09";
}
