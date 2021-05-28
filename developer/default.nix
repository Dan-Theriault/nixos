{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nixops nixfmt
    tokei
    direnv
    pandoc
    hunspell aspell
    jq
    shellcheck
    editorconfig-checker editorconfig-core-c
    gnumake
    guile
  ];

  # virtualisation.libvirtd.enable = true;
  users.extraUsers.dan.extraGroups = [ "libvirtd" "docker" "dialout" ];
  # networking.firewall.checkReversePath = "loose";

  # TODO
  environment.etc."deploy/ssh".text = ''
    Host github.com
      IdentityFile /etc/deploy/id_rsa
      StrictHostKeyChecking=no
  '';
}
