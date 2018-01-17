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
  ];
}
