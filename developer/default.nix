{ config, pkgs, ... }:

{
  imports = [
    ../developer/fish.nix
    ../developer/vim.nix
    # ../developer/android.nix
    ../developer/python.nix
  ];

  environment.systemPackages = with pkgs; [
    nixops # nixos-shell
    pgmanage pgcli pg_top 
    arduino platformio
    fd ripgrep 
    # tokei # currently broken in nixpkgs

    telnet netcat
    jq # postman
    jdk8

    shellcheck
    go
    sqlite

    emacs
    guile sbcl lispPackages.quicklisp
  ];

  # emacs service
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  # virtualisation.libvirtd.enable = true;
  users.extraUsers.dtheriault3.extraGroups = [ "libvirtd" "docker" "dialout" ];
  # networking.firewall.checkReversePath = "loose";

  environment.etc."deploy/ssh".text = ''
    Host github.com
      IdentityFile /etc/deploy/id_rsa
      StrictHostKeyChecking=no
  '';
}
