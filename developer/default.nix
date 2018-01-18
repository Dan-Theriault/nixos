{ config, pkgs, ... }:

{
  imports = [
    ../developer/android.nix
    ../developer/fish.nix
    ../developer/pkgs.nix
    ../developer/python.nix
    ../developer/vim.nix
  ];

  environment.systemPackages = with pkgs; [
    nixops
    pgmanage
    pgcli
    pg_top
  ];

  virtualisation.libvirtd.enable = true;
  users.extraUsers.dtheriault3.extraGroups = [ "libvirtd" ];
  networking.firewall.checkReversePath = false;
  services.postgresql.enable = true;
}
