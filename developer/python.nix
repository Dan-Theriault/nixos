{ config, pkgs, ... }:

let
    loadedPython = pkgs.python3Full.buildEnv.override rec {
      extraLibs = with pkgs.python3Packages; [
        black
        flake8
        ipython
        jedi
        matplotlib
        # neovim
        numpy
        pandas
        scipy
        yapf
      ];
    };
in
{
  environment.systemPackages = [ loadedPython pkgs.mypy ];
}
