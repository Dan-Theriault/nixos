{ config, pkgs, ... }:

{
  # TODO: Declarative configuration module for unison
  # This isn't available in nixos yet, so it's a good chance to get my feet wet with module development
  # Should include:
  # - Remotes configuration
  # - Icron script
  # - profiles
  environment.systemPackages = with pkgs; [ 
    # Probably dropping unison. It's utterly convinced it has synced files... that it hasn't.
    ocamlPackages.unison # unix-style tool wrapping ssh and rsync.

    # As much as I don't want to use syncthing (due to the global discovery and non-declarative nature),
    # it seems to be the best option right now.
    # So here's another TODO: stop using syncthing
    syncthing 
  ];
}
