{ config, pkgs, ... }:

{
  imports = [
    ../developer/fish.nix
    ../developer/pkgs.nix
    ../developer/python.nix
    ../developer/vim.nix
  ];
}
