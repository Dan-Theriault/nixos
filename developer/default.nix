{ config, pkgs, ... }:

{
  imports = [
    ../developer/android.nix
    ../developer/fish.nix
    ../developer/pkgs.nix
    ../developer/python.nix
    ../developer/vim.nix
  ];

  environment.systemPackages = with pkgs; [
    nixops
    pgmanage pgcli pg_top
    arduino platformio
    fd ripgrep 
    # tokei #currently broken
    telnet netcat
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  users.extraUsers.dtheriault3.extraGroups = [ "libvirtd" "docker" "dialout" ];
  networking.firewall.checkReversePath = false;
  services.postgresql.enable = true;

  nix = { 
    package = pkgs.nixUnstable;
  };

  environment.etc."deploy/ssh".text = ''
    Host github.com
      IdentityFile /etc/deploy/id_rsa
      StrictHostKeyChecking=no
  '';
}
