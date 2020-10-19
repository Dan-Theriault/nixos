{ config, pkgs, ... }:

let
  loadedPython = pkgs.python3Minimal.buildEnv.override rec {
    extraLibs = with pkgs.python3Packages; [
      black
      flake8
      ipython
      isort
      jedi
      matplotlib
      # neovim
      nose
      numpy
      pandas
      pytest
      scipy
      yapf
    ];
  };
in
{
  environment.systemPackages = with pkgs; [
    loadedPython
    mypy
    pipenv
  ];
}
