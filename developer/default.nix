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
    # tokei # currently broken in nixpkgs
    telnet netcat
  ];

  # virtualisation.libvirtd.enable = true;
  users.extraUsers.dtheriault3.extraGroups = [ "libvirtd" "docker" "dialout" ];
  # networking.firewall.checkReversePath = "loose";

  nix = { 
    package = pkgs.nixUnstable;
  };

  environment.etc."deploy/ssh".text = ''
    Host github.com
      IdentityFile /etc/deploy/id_rsa
      StrictHostKeyChecking=no
  '';
}
