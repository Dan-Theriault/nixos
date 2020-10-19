{ config, pkgs, ... }:

{
  imports = [
    ../developer/fish.nix
    ../developer/vim.nix
    # ../developer/android.nix
    ../developer/python.nix
  ];

  environment.systemPackages = with pkgs; [
    nixops nixfmt
    arduino platformio
    tokei
    direnv
    pandoc
    hunspell aspell
    telnet netcat
    jq
    shellcheck
    editorconfig-checker editorconfig-core-c

    jdk11
    kotlin ktlint
    scala sbt scalafmt metals ammonite coursier

    guile
    sbcl lispPackages.quicklisp
    racket

    coq

    glslang
  ];

  # virtualisation.libvirtd.enable = true;
  users.extraUsers.dtheriault3.extraGroups = [ "libvirtd" "docker" "dialout" ];
  # networking.firewall.checkReversePath = "loose";

  environment.etc."deploy/ssh".text = ''
    Host github.com
      IdentityFile /etc/deploy/id_rsa
      StrictHostKeyChecking=no
  '';
}
