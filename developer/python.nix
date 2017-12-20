{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    python3Full = pkgs.python3Full.buildEnv.override rec {
      extraLibs = with pkgs.python3Packages; [
        flake8
        flask
        ipython
        jedi
        matplotlib
        neovim
        numpy
        pandas
        scipy
        yapf
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    python3Full
    mypy
  ];
}
