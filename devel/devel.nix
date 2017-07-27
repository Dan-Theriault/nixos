{ config, pkgs, ... }:

{
  environment.systemPackages = ( with pkgs; [
    python35Packages.ipython
    python35Full

    shellcheck

    go

    sqlite
  ] );
}
