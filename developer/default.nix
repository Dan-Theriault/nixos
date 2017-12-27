{ config, pkgs, ... }:

{
  imports = [
    fish.nix
    haskell.nix
    pkgs.nix
    python.nix
    rust.nix
    vim.nix
  ];
}
