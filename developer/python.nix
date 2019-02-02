{ config, pkgs, ... }:

let
    loadedPython = pkgs.python36Full.buildEnv.override rec {
      extraLibs = with pkgs.python36Packages; [
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
