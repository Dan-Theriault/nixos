{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    python3Full = pkgs.python3Full.buildEnv.override rec {
      extraLibs = with pkgs.python3Packages; [
        bcrypt
        flake8
        flask
        flask_sqlalchemy
        ipython
        jedi
        matplotlib
        neovim
        numpy
        pandas
        scipy
        sqlalchemy
        yapf
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    python3Full
    mypy
  ];
}
