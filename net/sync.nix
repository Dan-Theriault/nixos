{ config, pkgs, ... }:

{
  # TODO: Declarative configuration module for unison
  # This isn't available in nixos yet, so it's a good chance to get my feet wet with module development
  # Should include:
  # - Remotes configuration
  # - Icron script
  # - profiles
  environment.systemPackages = with pkgs; [ ocamlPackages.unison ];
}
